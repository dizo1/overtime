require 'rails_helper'
describe 'navigate' do
    describe 'index' do
        it 'can be reached successfully' do
            visit posts_path
            expect(page.status_code).to eq(200)
        end
        it 'has a title of Posts' do
            visit posts_path
            expect(page).to have_content(/Posts/)
        end
    end
    
        describe 'creation' do
            before do
            user =  @user = User.create(email: "test@test.com", password:"123456", password_confirmation: "123456", first_name: "jon", last_name: "doe")  
            login_as(user, :scope => :user)
            visit new_post_path
          
        end
        
        it 'has a new form that can be reached' do
            expect(page.status_code).to eq(200)
        end
        
        it 'can be created from new form page' do
            fill_in 'post[date]', with: Date.today
            fill_in 'post[rationale]', with: "Dragons Rationale"
            click_on "Save"
        
            expect(page).to have_content("Dragons Rationale")
        end
        
        it 'will have a user associated with it' do
            fill_in 'post[date]', with: Date.today
            fill_in 'post[rationale]', with: "User_Association"
            click_on "Save" 
            expect(User.last.posts.last.rationale).to eq("User Association")
        end
    end
end