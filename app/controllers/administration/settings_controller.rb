class Administration::SettingsController < ApplicationController
  verify :method => :post, :only => :edit
  
  def index
    @settings = Setting.find_all_by_site_id_and_hidden(
      Site.current.id,
      false,
      :order => 'section, name'
    ).group_by &:section
  end
  
  def edit
    Setting.find_all_by_site_id(Site.current.id).each do |setting|
      next if setting.hidden?
      value = params[setting.id.to_s]
      value = value.split(/\n/) if value and setting.format == 'list'
      value = value == '' ? nil : value
      setting.update_attributes! :value => value
    end
    Setting.precache_settings(true)
    flash[:notice] = 'Settings saved.'
    redirect_to settings_url
  end
end
