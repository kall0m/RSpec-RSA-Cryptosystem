require 'prime'

class RSA
	def initialize n, e, d
		@n = n
		@e = e
		@d = d
	end

	def n
		@n
	end

	def e
		@e
	end

	def d
		@d
	end

	def new_key
		p, q, n, lambdaN, e, d = 0

		range = rand(2000)

		loop do
			p = rand(range)
			q = rand(range)

			n = p * q
			lambdaN = (p - 1).lcm(q - 1)

			e = [3, 5, 17, 65537].sample

			d = modinv(e, lambdaN)

			absDiff = (p - q).abs

			if absDiff != 4 && absDiff != 3 && absDiff != 2 && absDiff != 1 &&
				Prime.prime?(p) && Prime.prime?(q) &&
				d != "Modular inverse does not exist!"

				break
			end
		end

		[n, e, d]
	end

	def encrypt message
		encrypted = []

		message.chars.map! { |symbol|

			asciiNum = symbol.ord

			asciiNum = (asciiNum ** e) % n 

			encrypted.push(asciiNum)
		}

		encrypted.join("|")
	end

	def decrypt message
		encryptedValues = message.split("|")

		decrypted = ""

		encryptedValues.map! { |value|

			valueInt = value.to_i

			valueInt = ((valueInt ** d) % n ) # % 255 

			decrypted.concat(valueInt.chr)
		}

		decrypted
	end

private
	def extended_gcd a, b
		  if a == 0
				[b, 0, 1]
		  else
				g, y, x = extended_gcd(b % a , a)
				[g, x - (b / a) * y, y]
			end
	end

	def modinv integer, modulo
		  g, x, y = extended_gcd(integer, modulo)

		  if g != 1
				return "Modular inverse does not exist!"
		  end

		  x % modulo 
	end
end

=begin
rsa = RSA.new(*RSA.new(0, 0, 0).new_key)

p rsa.n

p rsa.e

p rsa.d

encrypt = rsa.encrypt("Right and round baby")
p encrypt
decrypt = rsa.decrypt(encrypt)
p decrypt
=end
