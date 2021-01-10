# SPDX-License-Identifier: GPL-3.0-or-later

# @summary Type definition for BIND's `update-policy` clause in the `zone` statement
#
# Reference: https://bind9.readthedocs.io/en/latest/reference.html#dynamic-update-policies
#
type Bind::Zone::UpdatePolicy = Variant[Enum['local'], Bind::Zone::UpdatePolicy::Rule]
