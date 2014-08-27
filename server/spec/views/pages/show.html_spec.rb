require 'spec_helper'

describe "/pages/show" do
  before(:each) do
    assign(:page, @page = FactoryGirl.build(:page))
    view.stub(:params).and_return( :controller => 'pages', :action => 'show' )
  end

  it "should succeed, and not have interpolated header information" do
    render
    rendered.should_not =~ /style/
    rendered.should_not =~ /body \{ color: green; \}/
    rendered.should_not =~ /<meta content='foo, bar' name='keywords'>/
    rendered.should_not =~ /<meta content='A foo page' name='description'>/
  end

  it "should interpolate css at the top of the page" do
    assign(:page, @page = FactoryGirl.build(:page, :css => 'body { color: green; }'))
    render :template => 'pages/show', :layout => 'layouts/application'

    # TODO: Capybara is refusing to match in the header.  Figure out why.
    # For now I'm just going to do regexp
    #
    #rendered.should have_css('style') do |scope|
    #  scope.should have_content(/body \{ color: green; \}/)
    #end
    rendered.should =~ /style/
    rendered.should =~ /body \{ color: green; \}/
  end

  it "should interpolate keywords at the top of the page" do
    assign(:page, @page = FactoryGirl.build(:page, :keywords => 'foo, bar'))
    render :template => 'pages/show', :layout => 'layouts/application'
    # TODO: Capybara is refusing to match in the header.  Figure out why.
    # For now I'm just going to do regexp
    #
    #rendered.should have_css('div') do |scope|
      #scope.should have_css("meta[name='keywords'][content='foo, bar']")
    #end
    #
    rendered.should =~ /<meta content='foo, bar' name='keywords'>/
  end

  it "should interpolate description at the top of the page" do
    assign(:page, @page = FactoryGirl.build(:page, :description => 'A foo page'))
    render :template => 'pages/show', :layout => 'layouts/application'


    # TODO: Capybara is refusing to match in the header.  Figure out why.
    # For now I'm just going to do regexp
    #
    #rendered.should have_css('head') do |scope|
      #scope.should have_css("meta[name='description'][content='A foo page']")
    #end

    rendered.should =~ /<meta content='A foo page' name='description'>/
  end

end
