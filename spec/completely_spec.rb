require 'spec_helper'
require 'spec/user_completion'
require 'nokogiri'
describe UserCompletion do
  context "Class" do
    subject { UserCompletion }
    it "should be able to define steps" do
      subject.steps.map(&:name).should include "Set up your profile"
    end

  end
  context "instance" do
    subject { UserCompletion.new(User.new) }
    it "should be able to define a path for steps" do
      subject.steps.first.path.should == '/profile/new'
    end

    it "should be able to declare dynamic paths" do
      subject.steps[1].path.should == '/profile/some-id'
    end
    it "should generate HTML from the steps" do
      html = subject.to_html
      doc = Nokogiri::XML(html)
      doc.css("ul.user-completion li.completion-item").size.should == 2
    end

    it "should add the completed_class to done tags" do
      html = subject.to_html
      doc = Nokogiri::XML(html)
      doc.css("ul.user-completion li.completion-item.done").size.should == 1
    end

    it "should have links within the li elements to the proper path" do
      html = subject.to_html
      doc = Nokogiri::XML(html)
      node = doc.css("li.completion-item.done a")[0]
      node[:href].should == '/profile/some-id'
      node.text.should   == 'Set up your dynamic profile'
    end
  end
end
