require 'rails_helper'

describe "ApiCartAppTestAccess" do

  before do
    visit "/"
  end

  it "get request to home page" do
    expect(page).to have_content "Тестовое задание для Level travel."
  end

  it "get map" do
    page.should have_css('div#map')
  end

  it "get table" do
    page.should have_css('table#buildings-tables')
  end

  it "get table-body" do
    page.should have_css('tbody#table-body')
  end

  it "get radius" do
    page.should have_css('input#radius')
  end

  it "get button for create_modal" do
    page.should have_css('a.create-address')
  end

  it "get create_modal" do
    page.should have_css('div#myModal')
  end

  it "get button create" do
    page.should have_css('a#submit-button')
  end

end