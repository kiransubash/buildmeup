#!/usr/bin/perl -w

use strict;
use warnings;

use Crypt::CBC;
use MIME::Base64;
use Digest::MD5 qw(md5_hex);

# RPMs needed on a RHEL/CENTOS box
#  - perl-Crypt-CBC-2.29-3.el6.noarch.rpm
#  - perl-Crypt-Rijndael-1.09-2.el6.x86_64.rpm
#  - perl-Crypt-OpenSSL-AES-0.02-9.el6.x86_64.rpm

# Notes - This is a reference only, dont use in production systems!
# keysize - restrict to 32
# cipher mode - Rijndael is the standard for AES
# If providing the IV, set literal_key to true, otherwise IV can be randomgenerated. Look at POD for more details
# padding - Standard padding is as specified in PCKS5
# header set to none does not include the IV, so when decrypting you need to have the IV.

my $cipher = Crypt::CBC->new(
        -key         => '69316762319209001281397952359137',
        -iv          => '3860294437179130',
        -cipher      => 'Crypt::Rijndael',
        -literal_key => 1,
        -header      => "none",
        -padding     => "standard",
        -keysize     => 32,
  );

my $plainText = "encrypt me, i'm secret";

# Encrypt and encode to a Base64
my $encrypted = $cipher->encrypt($plainText);
my $base64 = encode_base64($encrypted);
chomp $base64;

print("Ciphertext(base64 encoded) : $base64\n");

# Follow the reverse when decrypting, decode the base 64 string, and decrypt using the same Key/IV
my $todecode = decode_base64($base64);
my $decrypted = $cipher->decrypt($todecode);

print ("Decoded plaintext : $decrypted\n");
