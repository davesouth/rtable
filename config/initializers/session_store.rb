# Be sure to restart your server when you modify this file.

Rails.application.config.session_store(
  :cookie_store, key: '_rtable_session',
  expire_after: 1.year,
  same_site: :strict
)
