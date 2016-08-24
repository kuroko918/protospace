require 'rails_helper'

describe Prototype do
  describe 'associations' do
    context 'with comments' do
      let!(:prototype) { create(:prototype, :prototype_with_comments) }
      it 'deletes the comments when prototype is deleted' do
        expect { prototype.destroy }.to change { Comment.count }.by(-1)
      end
    end

    context 'with likes' do
      let!(:prototype) { create(:prototype, :prototype_with_likes) }
      it 'deletes the likes when prototype is deleted' do
        expect { prototype.destroy }.to change { Like.count }.by(-1)
      end
    end
  end

  describe 'validations' do
    context "with valid attributes" do
      it 'has a valid factory' do
        prototype = build(:prototype)
        expect(prototype).to be_valid
      end
    end

    context "without valid attributes" do
      it 'is missing a title' do
        prototype = build(:prototype, title: nil)
        prototype.valid?
        expect(prototype.errors[:title]).to include("can't be blank")
      end

      it 'is missing a catch_copy' do
        prototype = build(:prototype, catch_copy: nil)
        prototype.valid?
        expect(prototype.errors[:catch_copy]).to include("can't be blank")
      end

      it 'is missing a concept' do
        prototype = build(:prototype, concept: nil)
        prototype.valid?
        expect(prototype.errors[:concept]).to include("can't be blank")
      end
    end
  end

  describe '#liked_by?(user)' do
    context 'when liked by a user' do
      it 'returns true' do
        user = create(:user)
        prototype = create(:prototype, user: user)
        like = create(:like, prototype: prototype, user: user)
        expect(prototype.liked_by?(user)).to be_truthy
      end
    end

    context 'when not liked by a user' do
      it 'returns nil' do
        user = create(:user)
        another_user = create(:user)
        prototype = create(:prototype, user: another_user)
        like = create(:like, prototype: prototype, user: another_user)
        expect(prototype.liked_by?(user)).to be_falsey
      end
    end
  end

  describe '#reject_sub_image' do
    it "doesn't save a record with nil content" do
      image = build(:sub_image, image: nil)
      image.valid?
      expect(image.errors[:image]).to include("can't be blank")
    end
  end
end
