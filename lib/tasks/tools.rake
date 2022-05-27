require 'active_support/core_ext/hash/indifferent_access'

namespace :tools do

  desc 'Purge all draft memos'
  task :purge_draft_memos => :environment do
    tickets = Ticket.unscoped.gt(memos: []).and('memos.published_at' => nil)
    puts "#{tickets.count} tickets with draft memos"
    tickets.each do |ticket|
      puts "#{ticket.memos.draft.count} draft memos deleted"
      ticket.memos.draft.destroy_all
    end
  end

end