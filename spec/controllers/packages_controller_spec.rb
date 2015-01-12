require 'rails_helper'

RSpec.describe PackagesController, :type => :controller do

  describe "GET index" do
    before :each do
      @package_a = create(:package, name: 'foo', description: 'bar')
      @package_b = create(:package, name: 'bar', description: 'baz')
      @package_c = create(:package, name: 'baz', description: 'foo')
      @package_d = create(:package, name: 'foobar', description: 'baz')

      @package_a.casks << create(:cask)
      @package_b.casks << create(:cask)
      @package_c.casks << create(:cask)
      @package_d.casks << create(:cask)
    end

    context 'without params[:q]' do
      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end

      it "assigns all packages to @packages" do
        get :index
        expect(assigns(:packages)).to contain_exactly(@package_a, @package_b, @package_c, @package_d)
      end
    end

    context 'with params[:q]' do
      specify "q: 'foo'" do
        get :index, q: 'foo'
        expect(assigns(:packages)).to contain_exactly(@package_a, @package_c, @package_d)
      end

      specify "q: 'bar'" do
        get :index, q: 'bar'
        expect(assigns(:packages)).to contain_exactly(@package_a, @package_b, @package_d)
      end

      specify "q: 'baz'" do
        get :index, q: 'baz'
        expect(assigns(:packages)).to contain_exactly(@package_b, @package_c, @package_d)
      end

      specify "q: 'foo bar'" do
        get :index, q: 'foo bar'
        expect(assigns(:packages)).to contain_exactly(@package_a, @package_d)
      end

      specify "q: 'zoo'" do
        get :index, q: 'zoo'
        expect(assigns(:packages)).to contain_exactly()
      end
    end
  end

  describe "GET show" do
    let(:package) { create(:package) }

    it "returns http success" do
      get :show, id: package
      expect(response).to have_http_status(:success)
    end

    it "assigns the requested package to @package" do
      get :show, id: package
      expect(assigns(:package)).to eq package
    end
  end

end
