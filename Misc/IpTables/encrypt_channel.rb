require 'openssl'

# Create encryption
cipher = OpenSSL::Cipher.new('aes-256-cbc')
cipher.encrypt
key = cipher.random_key
iv = cipher.random_iv
cipher.key = key
cipher.iv = iv

buf = ""
File.open('/tmp/globix-channel.json.gz.enc', 'wb') do |sout|
    File.open('/tmp/globix-channel.json.gz', 'rb') do |sin|
        while sin.read(4096, buf)
            sout << cipher.update(buf)
        end
        sout << cipher.final
    end
end

# Create dycription
cipher = OpenSSL::Cipher.new('aes-256-cbc')
cipher.decrypt
cipher.key = key
cipher.iv = iv

buf = ""
File.open('/tmp/globix-channel.json.dec.gz', 'wb') do |sout|
    File.open('/tmp/globix-channel.json.gz.enc', 'rb') do |sin|
        while sin.read(4096, buf)
            sout << cipher.update(buf)
        end
        sout << cipher.final
    end
end


puts "Key is: #{key.unpack('H*').first}}"
puts "IV is: #{iv.unpack('H*').first}"
