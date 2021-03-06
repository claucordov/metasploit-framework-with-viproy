# -*- coding:binary -*-
require 'spec_helper'

require 'rex/java/serialization'
require 'msf/java/rmi/util'

describe Msf::Java::Rmi::Util do
  subject(:mod) do
    mod = ::Msf::Exploit.new
    mod.extend ::Msf::Java::Rmi::Util
    mod.send(:initialize)
    mod
  end

  let(:example_interface) do
    [
      {name: 'sayHello', descriptor: '()Ljava/lang/String;', exceptions: ['java.rmi.RemoteException']},
      {name: 'sayHelloTwo', descriptor: '(Ljava/lang/String;)Ljava/lang/String;', exceptions: ['java.rmi.RemoteException']}
    ]
  end

  let(:example_hash) do
    0x3e664fcbd9e953bb
  end

  let(:method_signature) do
    'sayHello()Ljava/lang/String;'
  end

  let(:method_hash) do
    0x53e0822d3e3724df
  end

  let(:dgc_interface) do
    [
      {name: 'clean', descriptor: '([Ljava/rmi/server/ObjID;JLjava/rmi/dgc/VMID;Z)V', exceptions: ['java.rmi.RemoteException']},
      {name: 'dirty', descriptor: '([Ljava/rmi/server/ObjID;JLjava/rmi/dgc/Lease;)Ljava/rmi/dgc/Lease;', exceptions: ['java.rmi.RemoteException']}
    ]
  end

  let(:dgc_hash) do
    0xf6b6898d8bf28643
  end

  let(:empty) { '' }
  let(:empty_io) { StringIO.new(empty) }
  let(:string) { "\x00\x04\x41\x42\x43\x44" }
  let(:string_io) { StringIO.new(string) }
  let(:int) { "\x00\x00\x00\x04" }
  let(:int_io) { StringIO.new(int) }

  let(:contents_unicast_ref) do
    "\x00\x0a\x55\x6e\x69\x63\x61\x73\x74\x52\x65\x66\x00\x0e\x31\x37" +
      "\x32\x2e\x31\x36\x2e\x31\x35\x38\x2e\x31\x33\x31\x00\x00\x0b\xf1" +
      "\x54\x74\xc4\x27\xb7\xa3\x4e\x9b\x51\xb5\x25\xf9\x00\x00\x01\x4a" +
      "\xdf\xd4\x57\x7e\x80\x01\x01"
  end

  let(:unicast_ref_io) do
    StringIO.new(Rex::Java::Serialization::Model::BlockData.new(nil, contents_unicast_ref).contents)
  end

  let(:ref_address) { '172.16.158.131' }
  let(:ref_port) { 3057 }
  let(:ref_object_number) { 6085704671348084379 }

  let(:unicast_ref) do
    {
      :address => '172.16.158.131',
      :object_number => 6085704671348084379,
      :port => 3057
    }
  end

  describe "#calculate_interface_hash" do
    context "when an example interface is provided" do
      it "generates a correct interface hash" do
        expect(mod.calculate_interface_hash(example_interface)).to eq(example_hash)
      end
    end

    context "when a DGC interface is provided" do
      it "generates a correct interface hash" do
        expect(mod.calculate_interface_hash(dgc_interface)).to eq(dgc_hash)
      end
    end
  end

  describe "#calculate_method_hash" do
    it "generates a correct interface hash" do
      expect(mod.calculate_method_hash(method_signature)).to eq(method_hash)
    end
  end

  describe "#extract_string" do
    context "when io contains a valid string" do
      it "returns the string" do
        expect(mod.extract_string(string_io)).to eq('ABCD')
      end
    end

    context "when io doesn't contain a valid string" do
      it "returns nil" do
        expect(mod.extract_string(empty_io)).to be_nil
      end
    end
  end

  describe "#extract_int" do
    context "when io contains a valid int" do
      it "returns the string" do
        expect(mod.extract_int(int_io)).to eq(4)
      end
    end

    context "when io doesn't contain a valid int" do
      it "returns nil" do
        expect(mod.extract_int(empty_io)).to be_nil
      end
    end
  end

  describe "#extract_reference" do
    context "when empty io" do
      it "returns nil" do
        expect(mod.extract_reference(empty_io)). to be_nil
      end
    end

    context "when valid io" do
      it "returns a hash" do
        expect(mod.extract_reference(unicast_ref_io)).to be_a(Hash)
      end

      it "returns a hash containing the address where the remote interface listens" do
        expect(mod.extract_reference(unicast_ref_io)[:address]).to eq(ref_address)
      end

      it "returns a hash containing the port where the remote interface listens" do
        expect(mod.extract_reference(unicast_ref_io)[:port]).to eq(ref_port)
      end

      it "returns a hash containing the object number of the remote interface" do
        expect(mod.extract_reference(unicast_ref_io)[:object_number]).to eq(ref_object_number)
      end

      it "returns a hash containing the extracted unique identifier" do
        expect(mod.extract_reference(unicast_ref_io)[:uid]).to be_a(Rex::Proto::Rmi::Model::UniqueIdentifier)
      end
    end
  end

end

