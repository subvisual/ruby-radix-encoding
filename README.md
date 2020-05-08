RadixEncoding
=============

Encode and decode strings using standard or custom versions of radix-based
encodings, such as Base16 (hexadecimal encoding), Base32 and Base64.

Thought for flexibility.


Installation
------------

Add this line to your application's Gemfile:

```ruby
gem "radix_encoding"
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install radix_encoding


Usage
-----


### Using a standard encoding

The following standard encodings are currently fully supported, and available
through constants under `RadixEncoding`:
- Standard Hexadecimal encoding through `RadixEncoding::BASE16` ([RFC4648]); 
- Standard Base32 encoding through `RadixEncoding::BASE32` ([RFC4648]); 
- Standard Base64 encoding through `RadixEncoding::BASE64` ([RFC4648]); 


### Using a custom encoding

To create your own encoding variant, use the `RadixEncoding::Encoding` class.

```ruby
digest_hexencode = RadixEncoding::Encoding.new(
  alphabet: "abcdefghijklmnopqrstuvwxyz234567",
  radix: 16,
  padding: "=",
)
```

:warning: Caveats for the current implementation:
- `alphabet` is **only** validated to have a length greater or equal to `radix`;
- `radix` **must** be a power of 2, or it fall-back to the greatest power of 2
  which is less than `radix`;
- `padding` **should** be a string with a single character, otherwise the
  behaviour is unspecified.


Development
-----------

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`rake spec` to run the tests. You can also run `bin/console` for an interactive
prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To
release a new version, update the version number in `version.rb`, and then run
`bundle exec rake release`, which will create a git tag for the version, push
git commits and tags, and push the `.gem` file to [rubygems.org].

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/subvisual/ruby-radix-encoding.


License
-----

RadixEncoding is copyright &copy; 2020 Subvisual, Lda.

It is open-source, made available for free, and is subject to the terms in
its [license].


About
-----

RadixEncoding was created and is maintained with :heart: by
[Subvisual][subvisual].

[![Subvisual][subvisual-logo]][subvisual]


[RFC4648]: https://tools.ietf.org/html/rfc4648
[license]: ./LICENSE.txt
[rubygems.org]: https://rubygems.org
[subvisual]: http://subvisual.com
[subvisual-logo]: https://raw.githubusercontent.com/subvisual/guides/master/github/templates/logos/blue.png
