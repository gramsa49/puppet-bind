require 'spec_helper_acceptance'

describe 'bind' do
  context 'when using defaults' do
    let(:pp) do
      <<-MANIFEST
        include bind
      MANIFEST
    end

    it 'applies idempotently' do
      idempotent_apply(pp)
    end

    describe package(PACKAGE_NAME) do
      it { is_expected.to be_installed }
    end

    describe service(SERVICE_NAME) do
      it { is_expected.to be_enabled }
      it { is_expected.to be_running }
    end

    describe file("/etc/default/#{SERVICE_NAME}") do
      its(:content) { is_expected.to match %r{RESOLVCONF=no} }
      its(:content) { is_expected.to match %r{OPTIONS="-u bind"} }
    end

    it_behaves_like 'a DNS server'
  end

  context 'when stopping the service' do
    let(:pp) do
      <<-MANIFEST
        class { 'bind':
          service_ensure => stopped,
        }
      MANIFEST
    end

    it 'applies idempotently' do
      idempotent_apply(pp)
    end

    describe service(SERVICE_NAME) do
      it { is_expected.not_to be_running }
    end
  end

  context 'when disabling the service' do
    let(:pp) do
      <<-MANIFEST
        class { 'bind':
          service_enable => false,
        }
      MANIFEST
    end

    it 'applies idempotently' do
      idempotent_apply(pp)
    end

    describe service(SERVICE_NAME) do
      it { is_expected.not_to be_enabled }
    end
  end

  context 'when uninstalling' do
    let(:pp) do
      <<-MANIFEST
        class { 'bind':
          package_ensure => absent,
        }
      MANIFEST
    end

    it 'applies idempotently' do
      idempotent_apply(pp)
    end

    describe package(PACKAGE_NAME) do
      it { is_expected.not_to be_installed }
    end

    describe service(SERVICE_NAME) do
      it { is_expected.not_to be_enabled }
      it { is_expected.not_to be_running }
    end
  end
end