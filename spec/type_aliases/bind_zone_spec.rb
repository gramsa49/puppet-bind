# frozen_string_literal: true

# SPDX-License-Identifier: GPL-3.0-or-later

require 'spec_helper'

describe 'Bind::Zone' do
  it { is_expected.not_to allow_value(:undef, 12, 'string') }
  it { is_expected.not_to allow_value(name: 'example.meh', file: 'not_absolute') }
  it { is_expected.not_to allow_value('name' => 'example.com', 'key-directory' => 'not-absolute-dir') }
  it { is_expected.to allow_value(name: 'example.com', class: 'IN', 'in-view' => 'view1') }
  it { is_expected.to allow_value(name: 'example.net', class: 'HS', 'in-view' => 'view2') }
  it { is_expected.to allow_value(name: 'example.org', class: 'CHAOS', 'in-view' => 'view3') }
  it { is_expected.to allow_value(name: 'example.us', class: 'IN', type: 'primary') }
  it { is_expected.to allow_value(name: 'example.google', type: 'secondary') }
  it { is_expected.to allow_value(name: 'example.jp', type: 'slave') }
  it { is_expected.to allow_value(name: '.', type: 'mirror') }
  it { is_expected.to allow_value(name: 'example.cn', type: 'hint') }
  it { is_expected.to allow_value(name: 'example.mx', type: 'stub') }
  it { is_expected.to allow_value(name: 'example.cx', type: 'static-stub') }
  it { is_expected.to allow_value(name: 'example.doctor', type: 'forward', forward: 'only', forwarders: ['2001:db8::1', 'example.net']) }
  it { is_expected.to allow_value(name: 'example.xzy', type: 'forward', forward: 'first', forwarders: ['192.0.2.1']) }
  it { is_expected.to allow_value(name: 'example.biz', type: 'redirect') }
  it { is_expected.to allow_value(name: 'example.zero', type: 'delegation-only') }
  it { is_expected.to allow_value(name: 'example.xxx', type: 'secondary', file: '/xxx', primaries: ['2001:db8::2']) }
  it { is_expected.to allow_value(name: 'example.xxx', type: 'slave', file: '/xxx', masters: ['2001:db8::2']) }
  it { is_expected.to allow_value('name' => 'example.com', 'key-directory' => '/absolute-dir') }
  it { is_expected.to allow_value('name' => 'example.com', 'allow-transfer' => ['2001:db8::/64']) }
  it { is_expected.to allow_value('name' => 'example.com', 'allow-update' => ['2001:db8:2::/64']) }
  it { is_expected.to allow_value('name' => 'example.com', 'also-notify' => ['2001:db8:1::/64']) }

  it do
    is_expected.to allow_value(
      name: 'example.uk',
      type: 'master',
      file: '/z',
      'auto-dnssec' => 'maintain',
      'inline-signing' => true,
    )
  end

  it { is_expected.to allow_value('name' => 'example.com', 'update-policy' => ['local']) }

  it do
    is_expected.to allow_value(
      'name' => 'example.com',
      'update-policy' => [
        'local',
        {
          permission: 'grant',
          identity: '*',
          ruletype: 'tcp-self',
          name: '.',
          types: 'PTR(1)',
        },
      ],
    )
  end

  it do
    is_expected.to allow_value(
      'name' => 'example.com',
      'update-policy' => [
        {
          permission: 'grant',
          identity: '*',
          ruletype: 'tcp-self',
          name: '.',
          types: 'PTR(1)',
        },
      ],
    )
  end
end
