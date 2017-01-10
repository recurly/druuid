require_relative '../druuid'

describe Druuid do
  describe '.gen' do
    it 'generates a UUID' do
      uuid = Druuid.gen
      uuid.should be_instance_of Bignum
      uuid.should_not eq Druuid.gen
    end

    let(:datetime) { Time.utc 2012, 2, 4, 8 }
    let(:prefix) { '111429436833' }
    context 'with a given time' do
      it 'generates the UUID against the time' do
        Druuid.gen(datetime).to_s[0, 12].should eq prefix
      end
    end

    let(:offset) { 60 * 60 * 24 }
    context 'with a given epoch' do
      it 'generates the UUID against the offset' do
        Druuid.gen(datetime + offset, offset).to_s[0, 12].should eq prefix
      end
    end

    context 'with a default epoch' do
      before { @old_epoch, Druuid.epoch = Druuid.epoch, offset }
      it 'generates the UUID against the offset' do
        Druuid.gen(datetime + offset).to_s[0, 12].should eq prefix
      end
      after { Druuid.epoch = @old_epoch }
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

  describe '.gen_range' do
    let(:beginning_datetime) { Time.utc 2015, 2, 3, 12, 2, 34 }
    let(:ending_datetime) { Time.utc 2015, 2, 3, 17, 56, 12}
    it 'provides the id range for the provided range of datetime' do
      Druuid.gen_range(beginning_datetime..ending_datetime).should eq 11936695196844032000..11936873186336964607
    end

    it 'results can be handed back to Druuid.time to reproduce the same datetime values' do
      generated_id_range = Druuid.gen_range(beginning_datetime..ending_datetime)
      converted_datetime_range = Druuid.time(generated_id_range.begin)..Druuid.time(generated_id_range.end)
      converted_datetime_range.should eq beginning_datetime..ending_datetime
    end
  end

end
