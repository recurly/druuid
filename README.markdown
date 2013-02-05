# Druuid

Date-relative UUID generation.


## Overview

Druuid generates 64-bit, time-sortable UUIDs.


## Dependencies/Installation

### Node

``` sh
$ brew install gmp     # `apt-get install libgmp' on Ubuntu.
$ npm install druuid
```

### Ruby

``` sh
$ gem install druuid
```


## Examples

### Node

``` javascript
var druuid = require('druuid');
var uuid = druuid.gen();
// => <BigInt 11142943683383068069>
druuid.time(uuid);
// => Sat Feb 04 2012 00:00:00 GMT-0800 (PST)
```

### Ruby

``` ruby
require 'druuid'
uuid = Druuid.gen
# => 11142943683383068069
Druuid.time uuid
# => 2012-02-04 00:00:00 -0800
```

## License

(The MIT License)

© 2013 Recurly Inc.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
