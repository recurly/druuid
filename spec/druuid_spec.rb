require_relative '../druuid'

describe Druuid do
  shared_examples "druuid generator" do |method|
    let(:datetime) { Time.utc 2012, 2, 4, 8 }
    let(:prefix) { '111429436833' }

    it "is a Bugnum" do
      Druuid.send(method).should be_instance_of Bignum
    end

    context 'with a given time' do
      it 'generates the UUID against the time' do
        Druuid.send(method, datetime).to_s[0, 12].should eq prefix
      end
    end

    let(:offset) { 60 * 60 * 24 }
    context 'with a given epoch' do
      it 'generates the UUID against the offset' do
        Druuid.send(method, datetime + offset, offset).to_s[0, 12].should eq prefix
      end
    end

    context 'with a default epoch' do
      before { @old_epoch, Druuid.epoch = Druuid.epoch, offset }
      it 'generates the UUID against the offset' do
        Druuid.send(method, datetime + offset).to_s[0, 12].should eq prefix
      end
      after { Druuid.epoch = @old_epoch }
    end
  end


  describe '.gen' do
    it_behaves_like 'druuid generator', :gen

    it 'generates a UUID' do
      uuid = Druuid.gen
      uuid.should_not eq Druuid.gen
    end
  end

  describe '.time' do
    let(:datetime) { Time.utc 2012, 2, 4, 8 }
    let(:uuid) { 11142943683383068069 }
    it 'determines when a UUID was generated' do
      Druuid.time(uuid).should eq datetime
    end

    let(:offset) { 60 * 60 * 24 }
    context 'with a given epoch' do
      it 'determines UUID date against the offset' do
        Druuid.time(uuid, offset).should eq datetime + offset
      end
    end

    context 'with a default epoch' do
      before { @old_epoch, Druuid.epoch = Druuid.epoch, offset }
      it 'determines UUID date against the offest' do
        Druuid.time(uuid).should eq datetime + offset
      end
      after { Druuid.epoch = @old_epoch }
    end
  end

  describe '.min_for_time' do
    it_behaves_like 'druuid generator', :min_for_time

    let(:datetime) { Time.utc 2012, 2, 4, 8 }
    it 'generates druuid without random bits' do
      random_bits = Druuid.min_for_time(Time.now) & Integer("0b" + ("1" * Druuid::NUM_RANDOM_BITS))
      random_bits.should be_zero
    end
  end
end
