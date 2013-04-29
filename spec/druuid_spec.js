
var druuid = require('../druuid')
  , bigint = require('bigint');

describe('druuid', function(){
  describe('.gen', function(){
    it('generates a UUID', function(){
      var uuid = druuid.gen();
      uuid.should.be.instanceOf(bigint);
      uuid.should.not.equal(druuid.gen());
    });

    var datetime = new Date(Date.UTC(2012, 1, 4, 8))
      , prefix = '111429436833';
    context('with a given time', function(){
      it('generates the UUID against the time', function(){
        var uuid = druuid.gen(datetime).toString();
        uuid.substr(0, 12).should.equal(prefix);
      });
    });

    var offset = 1000 * 60 * 60 * 24;
    context('with a given epoch', function(){
      it('generates the UUID against the offset', function(){
        var dateoffset = new Date(datetime);
        dateoffset.setMilliseconds(dateoffset.getMilliseconds() + offset);
        var uuid = druuid.gen(dateoffset, offset).toString();
        uuid.substr(0, 12).should.equal(prefix);
      });
    });

    context('with a default epoch', function(){
      var oldEpoch;
      before(function(){ oldEpoch = druuid.epoch, druuid.epoch = offset; });
      it('generates the UUID against the offset', function(){
        var dateoffset = new Date(datetime);
        dateoffset.setMilliseconds(dateoffset.getMilliseconds() + offset);
        var uuid = druuid.gen(dateoffset).toString();
        uuid.substr(0, 12).should.equal(prefix);
      });
      after(function(){ druuid.epoch = oldEpoch; });
    });
  });

  describe('.time', function(){
    var datetime = new Date(Date.UTC(2012, 1, 4, 8))
      , uuid = '11142943683383068069';
    it('determines when a UUID was generated', function(){
      druuid.time(uuid).should.eql(datetime);
    });

    var offset = 1000 * 60 * 60 * 24
      , dateoffset = new Date(datetime);
    dateoffset.setMilliseconds(dateoffset.getMilliseconds() + offset);
    context('with a given epoch', function(){
      it('determines UUID date against the offset', function(){
        druuid.time(uuid, offset).should.eql(dateoffset);
      });
    });

    context('with a default epoch', function(){
      var oldEpoch;
      before(function(){ oldEpoch = druuid.epoch, druuid.epoch = offset; });
      it('generates the UUID against the offset', function(){
        druuid.time(uuid).should.eql(dateoffset);
      });
      after(function(){ druuid.epoch = oldEpoch; });
    });
  });
});
