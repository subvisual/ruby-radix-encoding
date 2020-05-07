# frozen_string_literal: true

RSpec.describe RadixEncoding do
  it "has a version number" do
    expect(RadixEncoding::VERSION).not_to be nil
  end

  describe "::BASE32" do
    [
      { message: "ABCDE", expected: "IFBEGRCF" },
      { message: "ABCD",  expected: "IFBEGRA=" },
      { message: "ABC",   expected: "IFBEG===" },
      { message: "AB",    expected: "IFBA====" },
      { message: "A",     expected: "IE======" },
    ].each do |test_case|
      message = test_case[:message]
      expected = test_case[:expected]

      it "encodes '#{message}' to '#{expected}'" do
        actual = RadixEncoding::BASE32.encode(message)

        expect(actual).to eq expected
      end
    end

    it "encodes 'Hello World!' to 'JBSWY3DPEBLW64TMMQQQ===='" do
      message = "Hello World!"
      expected = "JBSWY3DPEBLW64TMMQQQ===="

      actual = RadixEncoding::BASE32.encode(message)

      expect(actual).to eq expected
    end
  end
end
