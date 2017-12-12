#BDD for RSA model

require "RSA"

RSpec.describe RSA do
	describe ".n, .e and .d" do
		let(:rsa) { RSA.new(9, 6, 3) }

		context ".n" do
			it "returns 9" do
				expect(rsa.n).to eql(9)
			end
		end

		context ".e" do
			it "returns 6" do
				expect(rsa.e).to eql(6)
			end
		end

		context ".d" do
			it "returns 3" do
				expect(rsa.d).to eql(3)
			end
		end
	end

	describe ".encrypt" do
		let(:rsa) { RSA.new(893, 17, 341) }

		it "encrypts 'TUES'" do
			expect(rsa.encrypt("TUES")).to eql("183|701|483|296")
		end

		it "encrypts '92341245'" do
			expect(rsa.encrypt("92341245")).to eql("475|331|497|414|83|331|414|166")
		end

		it "encrypts '#$@!*&'" do
			expect(rsa.encrypt("#$@!*&")).to eql("395|385|513")
		end

		it "encrypts '      '" do
			expect(rsa.encrypt("      ")).to eql("535|535|535|535|535|535")
		end

		it "encrypts ''" do
			expect(rsa.encrypt("")).to eql("")
		end
	end

	describe ".encrypt and .decrypt" do
		let(:rsa) { RSA.new(*RSA.new(0, 0, 0).new_key) }

		it "encrypts and decrypts 'RSA (cryptosystem)'" do
			expect(rsa.decrypt(rsa.encrypt("RSA (cryptosystem)"))).to eql("RSA (cryptosystem)")
		end

		it "encrypts and decrypts '0884410530'" do
			expect(rsa.decrypt(rsa.encrypt("0884410530"))).to eql("0884410530")
		end

		it "encrypts and decrypts '~!@#$%^&*()_+'" do
			expect(rsa.decrypt(rsa.encrypt("~!@#$%^&*()_+"))).to eql("~!@#$%^&*()_+")
		end

		it "encrypts and decrypts '7h3 qu1ck br0wn f0x'" do
			expect(rsa.decrypt(rsa.encrypt("7h3 qu1ck br0wn f0x"))).to eql("7h3 qu1ck br0wn f0x")
		end

		it "encrypts and decrypts '      '" do
			expect(rsa.decrypt(rsa.encrypt("      "))).to eql("      ")
		end

		it "encrypts and decrypts ''" do
			expect(rsa.decrypt(rsa.encrypt(""))).to eql("")
		end
	end
end
