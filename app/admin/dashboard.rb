ActiveAdmin.register_page 'Dashboard' do

  menu priority: 1, label: proc{ I18n.t('active_admin.dashboard') }

  content title: proc{ I18n.t('active_admin.dashboard') } do

    render partial: 'action', locals: { zones: Zone.select_list }

    div id: 'dashboard-map' do
    end
  end # content
end
