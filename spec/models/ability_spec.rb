require 'rails_helper'
require 'cancan/matchers'

describe Ability do
  include_context 'current_domain'

  subject(:ability) { Ability.new user }
  let(:user) { nil }

  describe 'when owner' do
    let(:user) { Fabricate :card, role: 'owner' }

    it { is_expected.to be_able_to :manage, Category }
    it { is_expected.to be_able_to :manage, Card }
    it { is_expected.to be_able_to :manage, Ticket }
  end





  # shared_examples_for 'staff_role' do
  #   it { is_expected.to be_able_to :read, Memo }
  #   it { is_expected.to be_able_to :create, Memo }
  #   it { is_expected.to be_able_to :update, Memo }
  #   it { is_expected.to be_able_to :destroy, Memo }

  #   it { is_expected.to_not be_able_to :manage, Transition }

  #   describe 'with doc' do
  #     it { is_expected.to be_able_to :read, Doc }

  #     context 'for old box' do
  #       let(:box) { Fabricate :box, created_at: 2.days.ago }
  #       let(:doc) { box.docs.create }

  #       it 'allow read, create, update, and destroy doc' do
  #         is_expected.to be_able_to :read, doc
  #         is_expected.to be_able_to :create, doc
  #         is_expected.to be_able_to :update, doc
  #         is_expected.to be_able_to :destroy, doc
  #       end
  #     end

  #     context 'for new memo' do
  #       let(:memo) { Fabricate :memo }
  #       let(:doc) { memo.docs.create }

  #       it 'allow read, create, update, and destroy doc' do
  #         is_expected.to be_able_to :read, doc
  #         is_expected.to be_able_to :create, doc
  #         is_expected.to be_able_to :update, doc
  #         is_expected.to be_able_to :destroy, doc
  #       end
  #     end
  #   end

  #   context 'with project' do
  #     let(:project) { Fabricate :project }

  #     it { should be_able_to :create, Project }

  #     it 'can read, update, destroy project' do
  #       is_expected.to be_able_to :read, project
  #       is_expected.to be_able_to :update, project
  #       is_expected.to be_able_to :destroy, project
  #     end

  #     it 'cannot destroy project once a memo is assigned' do
  #       project.memos.create body: 'Project memo'
  #       is_expected.to_not be_able_to :destroy, project
  #     end
  #   end

  # end # staff_role


  # describe 'when owner' do
  #   let(:user) { Fabricate :user, role: 'owner' }
  #   it_behaves_like 'staff_role'

  #   it { read_no_cud Revision }
  #   it { is_expected.to be_able_to :read, Report }
  #   it { is_expected.to be_able_to :manage, Card }
  #   it { is_expected.to be_able_to :manage, Contact }

  #   it { is_expected.to be_able_to :manage, User }
  #   it { is_expected.to be_able_to :manage, TagsController }

  #   context 'with project' do
  #     let(:project) { Fabricate :project}

  #     context 'for old memo' do
  #       let(:memo) { Fabricate :memo, created_at: 8.days.ago }
  #       let(:doc) { memo.docs.create }

  #       it 'can read, create, update, and destroy doc' do
  #         is_expected.to be_able_to :read, doc
  #         is_expected.to be_able_to :create, doc
  #         is_expected.to be_able_to :update, doc
  #         is_expected.to be_able_to :destroy, doc
  #       end
  #     end

  #     context 'with old memo' do
  #       let(:memo) { Fabricate :memo, created_at: 4.days.ago }

  #       it 'can update and destroy memo' do
  #         is_expected.to be_able_to :update, memo
  #         is_expected.to be_able_to :destroy, memo
  #       end
  #     end # with old memo
  #   end
  # end

  # describe 'when staff' do
  #   let(:user) { Fabricate :user, role: 'staff' }
  #   it_behaves_like 'staff_role'

  #   it { read_no_cud Revision }
  #   it { is_expected.to be_able_to :read, Report }
  #   it { is_expected.to be_able_to :manage, Card }
  #   it { is_expected.to be_able_to :manage, Contact }

  #   context 'for old memo' do
  #     let(:memo) { Fabricate :memo, created_at: 8.days.ago }
  #     let(:doc) { memo.docs.create }

  #     it 'cannot create, update, and destroy doc' do
  #       is_expected.to_not be_able_to :create, doc
  #       is_expected.to_not be_able_to :update, doc
  #       is_expected.to_not be_able_to :destroy, doc
  #     end
  #   end

  #   context 'with project' do
  #     let(:project) { Fabricate :project}

  #     context 'with old memo' do
  #       let(:memo) { Fabricate :memo, created_at: 8.days.ago }

  #       it 'cannot update or destroy memo' do
  #         is_expected.to_not be_able_to :update, memo
  #         is_expected.to_not be_able_to :destroy, memo
  #       end
  #     end # with old memo
  #   end

  #   it { no_crud User }
  #   it { no_crud TagsController }
  # end

  # describe 'when regular' do
  #   let(:user) { Fabricate :user, role: 'regular' }
  #   it_behaves_like 'staff_role'

  #   it { is_expected.to_not be_able_to :read, Report }
  #   it { is_expected.to be_able_to :read, Contact }
  #   it { is_expected.to be_able_to :create, Contact }
  #   it { is_expected.to_not be_able_to :delete, Contact }

  #   context 'with new contact' do
  #     let(:new_contact) { Fabricate :contact }
  #     it { is_expected.to be_able_to :update, new_contact }
  #   end

  #   context 'with old contact' do
  #     let(:old_contact) { Fabricate :contact, created_at: 31.days.ago }
  #     it { is_expected.to_not be_able_to :update, old_contact }
  #   end

  #   # it { no_crud Project }
  #   # it { no_crud Memo }
  #   # it { no_crud Transition }
  #   # it { no_crud Doc }
  #   # it { no_crud Project }

  #   it { read_no_cud Card }
  #   it { no_crud Revision }
  #   it { no_crud User }
  #   it { no_crud TagsController }
  # end

  # describe 'when guest' do
  #   let(:user) { Fabricate :user, role: 'guest' }
  #   it { is_expected.to_not be_able_to :read, Report }
  #   it { no_crud Revision }
  #   it { no_crud User }
  #   it { no_crud TagsController }
  #   it { no_crud Project }
  #   it { no_crud Card }
  #   it { no_crud Contact }
  #   it { no_crud Memo }
  #   it { no_crud Transition }
  #   it { no_crud Doc }
  #   it { no_crud Project }
  # end

  # private

  #   def no_crud(klass)
  #     is_expected.to_not be_able_to :read, klass
  #     is_expected.to_not be_able_to :create, klass
  #     is_expected.to_not be_able_to :update, klass
  #     is_expected.to_not be_able_to :destroy, klass
  #   end

  #   def read_no_cud(klass)
  #     is_expected.to be_able_to :read, klass
  #     is_expected.to_not be_able_to :create, klass
  #     is_expected.to_not be_able_to :update, klass
  #     is_expected.to_not be_able_to :destroy, klass
  #   end

end
