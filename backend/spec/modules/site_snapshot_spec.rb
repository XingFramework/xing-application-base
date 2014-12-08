require 'spec_helper'

describe SiteSnapshot do

  let :driver do
    double(Selenium::WebDriver)
  end

  let :navigator do
    double(Object)
  end

  let :element do
    double(Object)
  end

  let :site_page_set do
    double(SitePageSet)
  end

  let :wait do
    double(Selenium::WebDriver::Wait)
  end

  before do
    begin
      FileUtils.mkdir_p("#{ Rails.root }/spec/fixtures/sitemap_scratch")
      File.delete("#{ Rails.root }/spec/fixtures/sitemap_scratch/test.html")
    rescue
    end
  end

  # This feels like way too much mocking, but dont know how to test without completely
  # turning off selenium
  before do
    expect(Selenium::WebDriver).to receive(:for).with(:chrome).and_return(driver)
    expect(driver).to receive(:navigate).and_return(navigator)
    expect(navigator).to receive(:to).with("http://www.awesome.com/test")
    expect(driver).to receive(:find_element).with(:tag_name, "html").and_return(element)
    expect(element).to receive(:attribute).with("outerHTML").and_return("some html content")
    expect(Selenium::WebDriver::Wait).to receive(:new).and_return(wait)
    expect(wait).to receive(:until).and_yield
    expect(driver).to receive(:execute_script).and_return(true)
    expect(SitePageSet).to receive(:new).with("http://www.awesome.com/").and_return(site_page_set)
    expect(site_page_set).to receive(:visit_pages).and_yield("http://www.awesome.com/", "test")
    expect(driver).to receive(:close)
  end

  it "should read html contents from webdriver and output to the file" do
    SiteSnapshot.create!("http://www.awesome.com/")
    content = File.read("#{ Rails.root }/spec/fixtures/sitemap_scratch/test.html")
    expect(content).to eq("some html content")
  end

end
