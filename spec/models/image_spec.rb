require 'rails_helper'

describe Image do
  describe 'associations' do
    it 'is associated with prototypes' do
      prototype = create(:prototype)
      image = create(:main_image, prototype: prototype)
      expect(image.prototype).to eq prototype
    end
  end

  describe '#create' do
    it 'has the wrong content format' do
      image = build(:main_image, image: fixture_file_upload("img/sample.mp4", 'image/mp4'))
      image.valid?
      expect(image.errors[:image][0]).to include("can't be blank")
    end

    context 'with valid attributes' do
      it 'has a valid factory' do
        image = build(:main_image)
        expect(image).to be_valid
      end
    end

    context 'without content attribute' do
      it 'returns error' do
        image = build(:main_image, image: nil)
        image.valid?
        expect(image.errors[:image]).to include("can't be blank")
      end
    end

    context 'without status attribute' do
      it 'returns error' do
        image = build(:main_image, status: nil)
        image.valid?
        expect(image.errors[:status]).to include("can't be blank")
      end
    end
  end
end
