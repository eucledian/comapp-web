describe Api::UsersController do

  describe 'REST actions' do

    context '/login' do

      let!(:raw_password){ '123456' }
      let!(:app_user){
        create(:app_user, raw_password: raw_password)
      }

      it 'should authenticate as a valid user' do
        api_login(app_user.mail, raw_password)
        # valid response expectations
        response = JSON.parse(page.body)
        expect(response['token']).to be_present
      end

      it 'should reject an invalid login attempt' do
        api_login(app_user.mail, 'invalid_password')
        response = JSON.parse(page.body)
        # invalid response expectations
        expect(response['token']).to be_nil
      end
    end
  end
end
