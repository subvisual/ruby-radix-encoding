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

    [
      { message: "IFBEGRCF", expected: "ABCDE" },
      { message: "IFBEGRA=", expected: "ABCD" },
      { message: "IFBEG===", expected: "ABC" },
      { message: "IFBA====", expected: "AB" },
      { message: "IE======",     expected: "A" },
    ].each do |test_case|
      message = test_case[:message]
      expected = test_case[:expected]

      it "decodes '#{message}' to '#{expected}'" do
        actual = RadixEncoding::BASE32.decode(message)

        expect(actual).to eq expected
      end
    end

    it "decodes 'JBSWY3DPEBLW64TMMQQQ====' to 'Hello World!'" do
      message = "JBSWY3DPEBLW64TMMQQQ===="
      expected = "Hello World!"

      actual = RadixEncoding::BASE32.decode(message)

      expect(actual).to eq expected
    end
  end

  describe "::BASE64" do
    [
      { message: "ABCDE", expected: "QUJDREU=" },
      { message: "ABCD",  expected: "QUJDRA==" },
      { message: "ABC",   expected: "QUJD" },
      { message: "AB",    expected: "QUI=" },
      { message: "A",     expected: "QQ==" },
    ].each do |test_case|
      message = test_case[:message]
      expected = test_case[:expected]

      it "encodes '#{message}' to '#{expected}'" do
        actual = RadixEncoding::BASE64.encode(message)

        expect(actual).to eq expected
      end
    end

    it "encodes 'Hello World!' to 'SGVsbG8gV29ybGQh'" do
      message = "Hello World!"
      expected = "SGVsbG8gV29ybGQh"

      actual = RadixEncoding::BASE64.encode(message)

      expect(actual).to eq expected
    end

    [
      { message: "QUJDREU=", expected: "ABCDE" },
      { message: "QUJDRA==", expected: "ABCD" },
      { message: "QUJD",     expected: "ABC" },
      { message: "QUI=",     expected: "AB" },
      { message: "QQ==",     expected: "A" },
    ].each do |test_case|
      message = test_case[:message]
      expected = test_case[:expected]

      it "decodes '#{message}' to '#{expected}'" do
        actual = RadixEncoding::BASE64.decode(message)

        expect(actual).to eq expected
      end
    end

    it "decodes 'SGVsbG8gV29ybGQh' to 'Hello World!'" do
      message = "SGVsbG8gV29ybGQh"
      expected = "Hello World!"

      actual = RadixEncoding::BASE64.decode(message)

      expect(actual).to eq expected
    end
  end
end
