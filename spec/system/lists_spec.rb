# frozen_string_literal: true

require 'rails_helper'

describe "投稿のテスト" do
  let!(:list) { create(:list,title:"hoge",body:"body") }
  describe "トップ画面(top_path)のテスト" do
    before do
      visit top_path
    end
    context "表示の確認" do
      it "トップ画面（top_path)に『ここはTOPページです』が表示される" do
        expect(page).to have_content "ここはTOPページです"
      end
      it "top_pathが"/top"であるか" do
        expect(current_path).to eq("/top")
      end
    end
end

describe "投稿画面のテスト" do
  before do
    visit new_list_path
  end
  context "表示の確認" do
    it "投稿画面(new_list_path)が/lists/newであるか" do
      expect(current_path).to eq("/lists/new")
    end
    it "投稿ボタンが表示されているか" do
      expect(page).to hava_button "投稿"
    end
  end
  context "投稿処理のテスト" do
    it "投稿後のリダイレクト先は正しいか" do
      fill_in "list[title]",with: Faker::Lorem.characters(number:5)
      fill_in "list[body]",with: Faker::Lorem.characters(number:20)
      click_button "投稿"
      expect(page).to have_current_path list_path(List.last)
    end
  end
end

describe "一覧画面テスト" do
  before do
    visit lists_path
  end
  context "一覧の表示とリンクの確認" do
    it "投稿されたものが表示されているか" do
      expect(page).to have_content list.title
      expect(page).to have_link list.title
    end
  end
end

  
  