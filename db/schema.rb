# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_10_11_041615) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_stat_statements"
  enable_extension "pg_trgm"
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "access_tokens", force: :cascade do |t|
    t.string "owner_type"
    t.bigint "owner_id"
    t.string "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_type", "owner_id"], name: "index_access_tokens_on_owner_type_and_owner_id"
    t.index ["token"], name: "index_access_tokens_on_token", unique: true
  end

  create_table "account_users", force: :cascade do |t|
    t.bigint "account_id"
    t.bigint "user_id"
    t.integer "role", default: 0
    t.bigint "inviter_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "active_at", precision: nil
    t.integer "availability", default: 0, null: false
    t.boolean "auto_offline", default: true, null: false
    t.index ["account_id", "user_id"], name: "uniq_user_id_per_account_id", unique: true
    t.index ["account_id"], name: "index_account_users_on_account_id"
    t.index ["user_id"], name: "index_account_users_on_user_id"
  end

  create_table "accounts", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "locale", default: 0
    t.string "domain", limit: 100
    t.string "support_email", limit: 100
    t.integer "feature_flags", default: 0, null: false
    t.integer "auto_resolve_duration"
    t.jsonb "limits", default: {}
    t.jsonb "custom_attributes", default: {}
    t.integer "status", default: 0
    t.index ["status"], name: "index_accounts_on_status"
  end

  create_table "action_mailbox_inbound_emails", force: :cascade do |t|
    t.integer "status", default: 0, null: false
    t.string "message_id", null: false
    t.string "message_checksum", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["message_id", "message_checksum"], name: "index_action_mailbox_inbound_emails_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", precision: nil, null: false
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "address", id: :serial, force: :cascade do |t|
    t.datetime "createdAt", precision: nil, default: -> { "now()" }, null: false
    t.datetime "updatedAt", precision: nil, default: -> { "now()" }, null: false
    t.string "fullName", default: "", null: false
    t.string "company", default: "", null: false
    t.string "streetLine1", null: false
    t.string "streetLine2", default: "", null: false
    t.string "city", default: "", null: false
    t.string "province", default: "", null: false
    t.string "postalCode", default: "", null: false
    t.string "phoneNumber", default: "", null: false
    t.boolean "defaultShippingAddress", default: false, null: false
    t.boolean "defaultBillingAddress", default: false, null: false
    t.integer "customerId"
    t.integer "countryId"
    t.index ["countryId"], name: "IDX_d87215343c3a3a67e6a0b7f3ea"
    t.index ["customerId"], name: "IDX_dc34d382b493ade1f70e834c4d"
  end

  create_table "administrator", id: :serial, force: :cascade do |t|
    t.datetime "createdAt", precision: nil, default: -> { "now()" }, null: false
    t.datetime "updatedAt", precision: nil, default: -> { "now()" }, null: false
    t.datetime "deletedAt", precision: nil
    t.string "firstName", null: false
    t.string "lastName", null: false
    t.string "emailAddress", null: false
    t.integer "userId"
    t.index ["emailAddress"], name: "UQ_154f5c538b1576ccc277b1ed631", unique: true
    t.index ["userId"], name: "REL_1966e18ce6a39a82b19204704d", unique: true
  end

  create_table "agent_bot_inboxes", force: :cascade do |t|
    t.integer "inbox_id"
    t.integer "agent_bot_id"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "account_id"
  end

  create_table "agent_bots", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "outgoing_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "account_id"
    t.integer "bot_type", default: 0
    t.jsonb "bot_config", default: {}
    t.index ["account_id"], name: "index_agent_bots_on_account_id"
  end

  create_table "articles", force: :cascade do |t|
    t.integer "account_id", null: false
    t.integer "portal_id", null: false
    t.integer "category_id"
    t.integer "folder_id"
    t.string "title"
    t.text "description"
    t.text "content"
    t.integer "status"
    t.integer "views"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "author_id"
    t.bigint "associated_article_id"
    t.jsonb "meta", default: {}
    t.string "slug", null: false
    t.integer "position"
    t.index ["associated_article_id"], name: "index_articles_on_associated_article_id"
    t.index ["author_id"], name: "index_articles_on_author_id"
    t.index ["slug"], name: "index_articles_on_slug", unique: true
  end

  create_table "asset", id: :serial, force: :cascade do |t|
    t.datetime "createdAt", precision: nil, default: -> { "now()" }, null: false
    t.datetime "updatedAt", precision: nil, default: -> { "now()" }, null: false
    t.string "name", null: false
    t.string "type", null: false
    t.string "mimeType", null: false
    t.integer "width", default: 0, null: false
    t.integer "height", default: 0, null: false
    t.integer "fileSize", null: false
    t.string "source", null: false
    t.string "preview", null: false
    t.text "focalPoint"
  end

  create_table "asset_channels_channel", primary_key: ["assetId", "channelId"], force: :cascade do |t|
    t.integer "assetId", null: false
    t.integer "channelId", null: false
    t.index ["assetId"], name: "IDX_dc4e7435f9f5e9e6436bebd33b"
    t.index ["channelId"], name: "IDX_16ca9151a5153f1169da5b7b7e"
  end

  create_table "asset_tags_tag", primary_key: ["assetId", "tagId"], force: :cascade do |t|
    t.integer "assetId", null: false
    t.integer "tagId", null: false
    t.index ["assetId"], name: "IDX_9e412b00d4c6cee1a4b3d92071"
    t.index ["tagId"], name: "IDX_fb5e800171ffbe9823f2cc727f"
  end

  create_table "attachments", id: :serial, force: :cascade do |t|
    t.integer "file_type", default: 0
    t.string "external_url"
    t.float "coordinates_lat", default: 0.0
    t.float "coordinates_long", default: 0.0
    t.integer "message_id", null: false
    t.integer "account_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "fallback_title"
    t.string "extension"
    t.index ["account_id"], name: "index_attachments_on_account_id"
    t.index ["message_id"], name: "index_attachments_on_message_id"
  end

  create_table "audits", force: :cascade do |t|
    t.bigint "auditable_id"
    t.string "auditable_type"
    t.bigint "associated_id"
    t.string "associated_type"
    t.bigint "user_id"
    t.string "user_type"
    t.string "username"
    t.string "action"
    t.jsonb "audited_changes"
    t.integer "version", default: 0
    t.string "comment"
    t.string "remote_address"
    t.string "request_uuid"
    t.datetime "created_at", precision: nil
    t.index ["associated_type", "associated_id"], name: "associated_index"
    t.index ["auditable_type", "auditable_id", "version"], name: "auditable_index"
    t.index ["created_at"], name: "index_audits_on_created_at"
    t.index ["request_uuid"], name: "index_audits_on_request_uuid"
    t.index ["user_id", "user_type"], name: "user_index"
  end

  create_table "authentication_method", id: :serial, force: :cascade do |t|
    t.datetime "createdAt", precision: nil, default: -> { "now()" }, null: false
    t.datetime "updatedAt", precision: nil, default: -> { "now()" }, null: false
    t.string "identifier"
    t.string "passwordHash"
    t.string "verificationToken"
    t.string "passwordResetToken"
    t.string "identifierChangeToken"
    t.string "pendingIdentifier"
    t.string "strategy"
    t.string "externalIdentifier"
    t.text "metadata"
    t.string "type", null: false
    t.integer "userId"
    t.index ["type"], name: "IDX_a23445b2c942d8dfcae15b8de2"
    t.index ["userId"], name: "IDX_00cbe87bc0d4e36758d61bd31d"
  end

  create_table "automation_rules", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.string "name", null: false
    t.text "description"
    t.string "event_name", null: false
    t.jsonb "conditions", default: "{}", null: false
    t.jsonb "actions", default: "{}", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: true, null: false
    t.index ["account_id"], name: "index_automation_rules_on_account_id"
  end

  create_table "campaigns", force: :cascade do |t|
    t.integer "display_id", null: false
    t.string "title", null: false
    t.text "description"
    t.text "message", null: false
    t.integer "sender_id"
    t.boolean "enabled", default: true
    t.bigint "account_id", null: false
    t.bigint "inbox_id", null: false
    t.jsonb "trigger_rules", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "campaign_type", default: 0, null: false
    t.integer "campaign_status", default: 0, null: false
    t.jsonb "audience", default: []
    t.datetime "scheduled_at", precision: nil
    t.boolean "trigger_only_during_business_hours", default: false
    t.index ["account_id"], name: "index_campaigns_on_account_id"
    t.index ["campaign_status"], name: "index_campaigns_on_campaign_status"
    t.index ["campaign_type"], name: "index_campaigns_on_campaign_type"
    t.index ["inbox_id"], name: "index_campaigns_on_inbox_id"
    t.index ["scheduled_at"], name: "index_campaigns_on_scheduled_at"
  end

  create_table "canned_responses", id: :serial, force: :cascade do |t|
    t.integer "account_id", null: false
    t.string "short_code"
    t.text "content"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "categories", force: :cascade do |t|
    t.integer "account_id", null: false
    t.integer "portal_id", null: false
    t.string "name"
    t.text "description"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "locale", default: "en"
    t.string "slug", null: false
    t.bigint "parent_category_id"
    t.bigint "associated_category_id"
    t.index ["associated_category_id"], name: "index_categories_on_associated_category_id"
    t.index ["locale", "account_id"], name: "index_categories_on_locale_and_account_id"
    t.index ["locale"], name: "index_categories_on_locale"
    t.index ["parent_category_id"], name: "index_categories_on_parent_category_id"
    t.index ["slug", "locale", "portal_id"], name: "index_categories_on_slug_and_locale_and_portal_id", unique: true
  end

  create_table "channel", id: :serial, force: :cascade do |t|
    t.datetime "createdAt", precision: nil, default: -> { "now()" }, null: false
    t.datetime "updatedAt", precision: nil, default: -> { "now()" }, null: false
    t.string "code", null: false
    t.string "token", null: false
    t.string "description", default: ""
    t.string "defaultLanguageCode", null: false
    t.text "availableLanguageCodes"
    t.string "defaultCurrencyCode", null: false
    t.text "availableCurrencyCodes"
    t.boolean "trackInventory", default: true, null: false
    t.integer "outOfStockThreshold", default: 0, null: false
    t.boolean "pricesIncludeTax", null: false
    t.integer "sellerId"
    t.integer "defaultTaxZoneId"
    t.integer "defaultShippingZoneId"
    t.index ["code"], name: "UQ_06127ac6c6d913f4320759971db", unique: true
    t.index ["defaultShippingZoneId"], name: "IDX_c9ca2f58d4517460435cbd8b4c"
    t.index ["defaultTaxZoneId"], name: "IDX_afe9f917a1c82b9e9e69f7c612"
    t.index ["sellerId"], name: "IDX_af2116c7e176b6b88dceceeb74"
    t.index ["token"], name: "UQ_842699fce4f3470a7d06d89de88", unique: true
  end

  create_table "channel_api", force: :cascade do |t|
    t.integer "account_id", null: false
    t.string "webhook_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "identifier"
    t.string "hmac_token"
    t.boolean "hmac_mandatory", default: false
    t.jsonb "additional_attributes", default: {}
    t.index ["hmac_token"], name: "index_channel_api_on_hmac_token", unique: true
    t.index ["identifier"], name: "index_channel_api_on_identifier", unique: true
  end

  create_table "channel_email", force: :cascade do |t|
    t.integer "account_id", null: false
    t.string "email", null: false
    t.string "forward_to_email", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "imap_enabled", default: false
    t.string "imap_address", default: ""
    t.integer "imap_port", default: 0
    t.string "imap_login", default: ""
    t.string "imap_password", default: ""
    t.boolean "imap_enable_ssl", default: true
    t.datetime "imap_inbox_synced_at", precision: nil
    t.boolean "smtp_enabled", default: false
    t.string "smtp_address", default: ""
    t.integer "smtp_port", default: 0
    t.string "smtp_login", default: ""
    t.string "smtp_password", default: ""
    t.string "smtp_domain", default: ""
    t.boolean "smtp_enable_starttls_auto", default: true
    t.string "smtp_authentication", default: "login"
    t.string "smtp_openssl_verify_mode", default: "none"
    t.boolean "smtp_enable_ssl_tls", default: false
    t.jsonb "provider_config", default: {}
    t.string "provider"
    t.index ["email"], name: "index_channel_email_on_email", unique: true
    t.index ["forward_to_email"], name: "index_channel_email_on_forward_to_email", unique: true
  end

  create_table "channel_facebook_pages", id: :serial, force: :cascade do |t|
    t.string "page_id", null: false
    t.string "user_access_token", null: false
    t.string "page_access_token", null: false
    t.integer "account_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "instagram_id"
    t.index ["page_id", "account_id"], name: "index_channel_facebook_pages_on_page_id_and_account_id", unique: true
    t.index ["page_id"], name: "index_channel_facebook_pages_on_page_id"
  end

  create_table "channel_line", force: :cascade do |t|
    t.integer "account_id", null: false
    t.string "line_channel_id", null: false
    t.string "line_channel_secret", null: false
    t.string "line_channel_token", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["line_channel_id"], name: "index_channel_line_on_line_channel_id", unique: true
  end

  create_table "channel_sms", force: :cascade do |t|
    t.integer "account_id", null: false
    t.string "phone_number", null: false
    t.string "provider", default: "default"
    t.jsonb "provider_config", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["phone_number"], name: "index_channel_sms_on_phone_number", unique: true
  end

  create_table "channel_telegram", force: :cascade do |t|
    t.string "bot_name"
    t.integer "account_id", null: false
    t.string "bot_token", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bot_token"], name: "index_channel_telegram_on_bot_token", unique: true
  end

  create_table "channel_twilio_sms", force: :cascade do |t|
    t.string "phone_number"
    t.string "auth_token", null: false
    t.string "account_sid", null: false
    t.integer "account_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "medium", default: 0
    t.string "messaging_service_sid"
    t.string "api_key_sid"
    t.index ["account_sid", "phone_number"], name: "index_channel_twilio_sms_on_account_sid_and_phone_number", unique: true
    t.index ["messaging_service_sid"], name: "index_channel_twilio_sms_on_messaging_service_sid", unique: true
    t.index ["phone_number"], name: "index_channel_twilio_sms_on_phone_number", unique: true
  end

  create_table "channel_twitter_profiles", force: :cascade do |t|
    t.string "profile_id", null: false
    t.string "twitter_access_token", null: false
    t.string "twitter_access_token_secret", null: false
    t.integer "account_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "tweets_enabled", default: true
    t.index ["account_id", "profile_id"], name: "index_channel_twitter_profiles_on_account_id_and_profile_id", unique: true
  end

  create_table "channel_web_widgets", id: :serial, force: :cascade do |t|
    t.string "website_url"
    t.integer "account_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "website_token"
    t.string "widget_color", default: "#1f93ff"
    t.string "welcome_title"
    t.string "welcome_tagline"
    t.integer "feature_flags", default: 7, null: false
    t.integer "reply_time", default: 0
    t.string "hmac_token"
    t.boolean "pre_chat_form_enabled", default: false
    t.jsonb "pre_chat_form_options", default: {}
    t.boolean "hmac_mandatory", default: false
    t.boolean "continuity_via_email", default: true, null: false
    t.index ["hmac_token"], name: "index_channel_web_widgets_on_hmac_token", unique: true
    t.index ["website_token"], name: "index_channel_web_widgets_on_website_token", unique: true
  end

  create_table "channel_whatsapp", force: :cascade do |t|
    t.integer "account_id", null: false
    t.string "phone_number", null: false
    t.string "provider", default: "default"
    t.jsonb "provider_config", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "message_templates", default: {}
    t.datetime "message_templates_last_updated", precision: nil
    t.index ["phone_number"], name: "index_channel_whatsapp_on_phone_number", unique: true
  end

  create_table "collection", id: :serial, force: :cascade do |t|
    t.datetime "createdAt", precision: nil, default: -> { "now()" }, null: false
    t.datetime "updatedAt", precision: nil, default: -> { "now()" }, null: false
    t.boolean "isRoot", default: false, null: false
    t.integer "position", null: false
    t.boolean "isPrivate", default: false, null: false
    t.text "filters", null: false
    t.boolean "inheritFilters", default: true, null: false
    t.integer "parentId"
    t.integer "featuredAssetId"
    t.index ["featuredAssetId"], name: "IDX_7256fef1bb42f1b38156b7449f"
  end

  create_table "collection_asset", id: :serial, force: :cascade do |t|
    t.datetime "createdAt", precision: nil, default: -> { "now()" }, null: false
    t.datetime "updatedAt", precision: nil, default: -> { "now()" }, null: false
    t.integer "assetId", null: false
    t.integer "position", null: false
    t.integer "collectionId", null: false
    t.index ["assetId"], name: "IDX_51da53b26522dc0525762d2de8"
    t.index ["collectionId"], name: "IDX_1ed9e48dfbf74b5fcbb35d3d68"
  end

  create_table "collection_channels_channel", primary_key: ["collectionId", "channelId"], force: :cascade do |t|
    t.integer "collectionId", null: false
    t.integer "channelId", null: false
    t.index ["channelId"], name: "IDX_7216ab24077cf5cbece7857dbb"
    t.index ["collectionId"], name: "IDX_cdbf33ffb5d451916125152008"
  end

  create_table "collection_closure", primary_key: ["id_ancestor", "id_descendant"], force: :cascade do |t|
    t.integer "id_ancestor", null: false
    t.integer "id_descendant", null: false
    t.index ["id_ancestor"], name: "IDX_c309f8cd152bbeaea08491e0c6"
    t.index ["id_descendant"], name: "IDX_457784c710f8ac9396010441f6"
  end

  create_table "collection_product_variants_product_variant", primary_key: ["collectionId", "productVariantId"], force: :cascade do |t|
    t.integer "collectionId", null: false
    t.integer "productVariantId", null: false
    t.index ["collectionId"], name: "IDX_6faa7b72422d9c4679e2f186ad"
    t.index ["productVariantId"], name: "IDX_fb05887e2867365f236d7dd95e"
  end

  create_table "collection_translation", id: :serial, force: :cascade do |t|
    t.datetime "createdAt", precision: nil, default: -> { "now()" }, null: false
    t.datetime "updatedAt", precision: nil, default: -> { "now()" }, null: false
    t.string "languageCode", null: false
    t.string "name", null: false
    t.string "slug", null: false
    t.text "description", null: false
    t.integer "baseId"
    t.index ["baseId"], name: "IDX_e329f9036210d75caa1d8f2154"
    t.index ["slug"], name: "IDX_9f9da7d94b0278ea0f7831e1fc"
  end

  create_table "contact_inboxes", force: :cascade do |t|
    t.bigint "contact_id"
    t.bigint "inbox_id"
    t.string "source_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "hmac_verified", default: false
    t.string "pubsub_token"
    t.index ["contact_id"], name: "index_contact_inboxes_on_contact_id"
    t.index ["inbox_id", "source_id"], name: "index_contact_inboxes_on_inbox_id_and_source_id", unique: true
    t.index ["inbox_id"], name: "index_contact_inboxes_on_inbox_id"
    t.index ["pubsub_token"], name: "index_contact_inboxes_on_pubsub_token", unique: true
    t.index ["source_id"], name: "index_contact_inboxes_on_source_id"
  end

  create_table "contacts", id: :serial, force: :cascade do |t|
    t.string "name", default: ""
    t.string "email"
    t.string "phone_number"
    t.integer "account_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.jsonb "additional_attributes", default: {}
    t.string "identifier"
    t.jsonb "custom_attributes", default: {}
    t.datetime "last_activity_at", precision: nil
    t.index "lower((email)::text), account_id", name: "index_contacts_on_lower_email_account_id"
    t.index ["account_id", "email", "phone_number", "identifier"], name: "index_contacts_on_nonempty_fields", where: "(((email)::text <> ''::text) OR ((phone_number)::text <> ''::text) OR ((identifier)::text <> ''::text))"
    t.index ["account_id"], name: "index_contacts_on_account_id"
    t.index ["account_id"], name: "index_resolved_contact_account_id", where: "(((email)::text <> ''::text) OR ((phone_number)::text <> ''::text) OR ((identifier)::text <> ''::text))"
    t.index ["email", "account_id"], name: "uniq_email_per_account_contact", unique: true
    t.index ["identifier", "account_id"], name: "uniq_identifier_per_account_contact", unique: true
    t.index ["name", "email", "phone_number", "identifier"], name: "index_contacts_on_name_email_phone_number_identifier", opclass: :gin_trgm_ops, using: :gin
    t.index ["phone_number", "account_id"], name: "index_contacts_on_phone_number_and_account_id"
  end

  create_table "conversation_participants", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "user_id", null: false
    t.bigint "conversation_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_conversation_participants_on_account_id"
    t.index ["conversation_id"], name: "index_conversation_participants_on_conversation_id"
    t.index ["user_id", "conversation_id"], name: "index_conversation_participants_on_user_id_and_conversation_id", unique: true
    t.index ["user_id"], name: "index_conversation_participants_on_user_id"
  end

  create_table "conversations", id: :serial, force: :cascade do |t|
    t.integer "account_id", null: false
    t.integer "inbox_id", null: false
    t.integer "status", default: 0, null: false
    t.integer "assignee_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.bigint "contact_id"
    t.integer "display_id", null: false
    t.datetime "contact_last_seen_at", precision: nil
    t.datetime "agent_last_seen_at", precision: nil
    t.jsonb "additional_attributes", default: {}
    t.bigint "contact_inbox_id"
    t.uuid "uuid", default: -> { "gen_random_uuid()" }, null: false
    t.string "identifier"
    t.datetime "last_activity_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.bigint "team_id"
    t.bigint "campaign_id"
    t.datetime "snoozed_until", precision: nil
    t.jsonb "custom_attributes", default: {}
    t.datetime "assignee_last_seen_at", precision: nil
    t.datetime "first_reply_created_at", precision: nil
    t.integer "priority"
    t.bigint "sla_policy_id"
    t.datetime "waiting_since"
    t.index ["account_id", "display_id"], name: "index_conversations_on_account_id_and_display_id", unique: true
    t.index ["account_id", "id"], name: "index_conversations_on_id_and_account_id"
    t.index ["account_id", "inbox_id", "status", "assignee_id"], name: "conv_acid_inbid_stat_asgnid_idx"
    t.index ["account_id"], name: "index_conversations_on_account_id"
    t.index ["assignee_id", "account_id"], name: "index_conversations_on_assignee_id_and_account_id"
    t.index ["campaign_id"], name: "index_conversations_on_campaign_id"
    t.index ["contact_id"], name: "index_conversations_on_contact_id"
    t.index ["contact_inbox_id"], name: "index_conversations_on_contact_inbox_id"
    t.index ["first_reply_created_at"], name: "index_conversations_on_first_reply_created_at"
    t.index ["inbox_id"], name: "index_conversations_on_inbox_id"
    t.index ["last_activity_at"], name: "index_conversations_on_last_activity_at"
    t.index ["priority"], name: "index_conversations_on_priority"
    t.index ["status", "account_id"], name: "index_conversations_on_status_and_account_id"
    t.index ["status", "priority"], name: "index_conversations_on_status_and_priority"
    t.index ["team_id"], name: "index_conversations_on_team_id"
    t.index ["uuid"], name: "index_conversations_on_uuid", unique: true
    t.index ["waiting_since"], name: "index_conversations_on_waiting_since"
  end

  create_table "csat_survey_responses", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "conversation_id", null: false
    t.bigint "message_id", null: false
    t.integer "rating", null: false
    t.text "feedback_message"
    t.bigint "contact_id", null: false
    t.bigint "assigned_agent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_csat_survey_responses_on_account_id"
    t.index ["assigned_agent_id"], name: "index_csat_survey_responses_on_assigned_agent_id"
    t.index ["contact_id"], name: "index_csat_survey_responses_on_contact_id"
    t.index ["conversation_id"], name: "index_csat_survey_responses_on_conversation_id"
    t.index ["message_id"], name: "index_csat_survey_responses_on_message_id", unique: true
  end

  create_table "custom_attribute_definitions", force: :cascade do |t|
    t.string "attribute_display_name"
    t.string "attribute_key"
    t.integer "attribute_display_type", default: 0
    t.integer "default_value"
    t.integer "attribute_model", default: 0
    t.bigint "account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "attribute_description"
    t.jsonb "attribute_values", default: []
    t.index ["account_id"], name: "index_custom_attribute_definitions_on_account_id"
    t.index ["attribute_key", "attribute_model", "account_id"], name: "attribute_key_model_index", unique: true
  end

  create_table "custom_filters", force: :cascade do |t|
    t.string "name", null: false
    t.integer "filter_type", default: 0, null: false
    t.jsonb "query", default: "{}", null: false
    t.bigint "account_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_custom_filters_on_account_id"
    t.index ["user_id"], name: "index_custom_filters_on_user_id"
  end

  create_table "customer", id: :serial, force: :cascade do |t|
    t.datetime "createdAt", precision: nil, default: -> { "now()" }, null: false
    t.datetime "updatedAt", precision: nil, default: -> { "now()" }, null: false
    t.datetime "deletedAt", precision: nil
    t.string "title"
    t.string "firstName", null: false
    t.string "lastName", null: false
    t.string "phoneNumber"
    t.string "emailAddress", null: false
    t.integer "userId"
    t.boolean "customFields__fix_relational_custom_fields__", comment: "A work-around needed when only relational custom fields are defined on an entity"
    t.index ["userId"], name: "REL_3f62b42ed23958b120c235f74d", unique: true
  end

  create_table "customer_channels_channel", primary_key: ["customerId", "channelId"], force: :cascade do |t|
    t.integer "customerId", null: false
    t.integer "channelId", null: false
    t.index ["channelId"], name: "IDX_dc9f69207a8867f83b0fd257e3"
    t.index ["customerId"], name: "IDX_a842c9fe8cd4c8ff31402d172d"
  end

  create_table "customer_custom_fields_notification_notification_item", primary_key: ["customerId", "notificationItemId"], force: :cascade do |t|
    t.integer "customerId", null: false
    t.integer "notificationItemId", null: false
    t.index ["customerId"], name: "IDX_abe895a39289ce0aae0e4818d3"
    t.index ["notificationItemId"], name: "IDX_d4919f7de35b4ab978507fcac2"
  end

  create_table "customer_group", id: :serial, force: :cascade do |t|
    t.datetime "createdAt", precision: nil, default: -> { "now()" }, null: false
    t.datetime "updatedAt", precision: nil, default: -> { "now()" }, null: false
    t.string "name", null: false
  end

  create_table "customer_groups_customer_group", primary_key: ["customerId", "customerGroupId"], force: :cascade do |t|
    t.integer "customerId", null: false
    t.integer "customerGroupId", null: false
    t.index ["customerGroupId"], name: "IDX_85feea3f0e5e82133605f78db0"
    t.index ["customerId"], name: "IDX_b823a3c8bf3b78d3ed68736485"
  end

  create_table "dashboard_apps", force: :cascade do |t|
    t.string "title", null: false
    t.jsonb "content", default: []
    t.bigint "account_id", null: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_dashboard_apps_on_account_id"
    t.index ["user_id"], name: "index_dashboard_apps_on_user_id"
  end

  create_table "data_imports", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.string "data_type", null: false
    t.integer "status", default: 0, null: false
    t.text "processing_errors"
    t.integer "total_records"
    t.integer "processed_records"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_data_imports_on_account_id"
  end

  create_table "email_templates", force: :cascade do |t|
    t.string "name", null: false
    t.text "body", null: false
    t.integer "account_id"
    t.integer "template_type", default: 1
    t.integer "locale", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "account_id"], name: "index_email_templates_on_name_and_account_id", unique: true
  end

  create_table "facet", id: :serial, force: :cascade do |t|
    t.datetime "createdAt", precision: nil, default: -> { "now()" }, null: false
    t.datetime "updatedAt", precision: nil, default: -> { "now()" }, null: false
    t.boolean "isPrivate", default: false, null: false
    t.string "code", null: false
    t.index ["code"], name: "UQ_0c9a5d053fdf4ebb5f0490b40fd", unique: true
  end

  create_table "facet_channels_channel", primary_key: ["facetId", "channelId"], force: :cascade do |t|
    t.integer "facetId", null: false
    t.integer "channelId", null: false
    t.index ["channelId"], name: "IDX_2a8ea404d05bf682516184db7d"
    t.index ["facetId"], name: "IDX_ca796020c6d097e251e5d6d2b0"
  end

  create_table "facet_translation", id: :serial, force: :cascade do |t|
    t.datetime "createdAt", precision: nil, default: -> { "now()" }, null: false
    t.datetime "updatedAt", precision: nil, default: -> { "now()" }, null: false
    t.string "languageCode", null: false
    t.string "name", null: false
    t.integer "baseId"
    t.index ["baseId"], name: "IDX_eaea53f44bf9e97790d38a3d68"
  end

  create_table "facet_value", id: :serial, force: :cascade do |t|
    t.datetime "createdAt", precision: nil, default: -> { "now()" }, null: false
    t.datetime "updatedAt", precision: nil, default: -> { "now()" }, null: false
    t.string "code", null: false
    t.integer "facetId"
    t.index ["facetId"], name: "IDX_d101dc2265a7341be3d94968c5"
  end

  create_table "facet_value_channels_channel", primary_key: ["facetValueId", "channelId"], force: :cascade do |t|
    t.integer "facetValueId", null: false
    t.integer "channelId", null: false
    t.index ["channelId"], name: "IDX_e1d54c0b9db3e2eb17faaf5919"
    t.index ["facetValueId"], name: "IDX_ad690c1b05596d7f52e52ffeed"
  end

  create_table "facet_value_translation", id: :serial, force: :cascade do |t|
    t.datetime "createdAt", precision: nil, default: -> { "now()" }, null: false
    t.datetime "updatedAt", precision: nil, default: -> { "now()" }, null: false
    t.string "languageCode", null: false
    t.string "name", null: false
    t.integer "baseId"
    t.index ["baseId"], name: "IDX_3d6e45823b65de808a66cb1423"
  end

  create_table "fcm_token", primary_key: ["id", "customerId"], force: :cascade do |t|
    t.datetime "createdAt", precision: nil, default: -> { "now()" }, null: false
    t.datetime "updatedAt", precision: nil, default: -> { "now()" }, null: false
    t.string "token", null: false
    t.serial "id", null: false
    t.integer "customerUserid"
    t.datetime "customerCreatedat", precision: nil, default: -> { "now()" }, null: false
    t.datetime "customerUpdatedat", precision: nil, default: -> { "now()" }, null: false
    t.datetime "customerDeletedat", precision: nil
    t.string "customerTitle"
    t.string "customerFirstname", null: false
    t.string "customerLastname", null: false
    t.string "customerPhonenumber"
    t.string "customerEmailaddress", null: false
    t.serial "customerId", null: false
    t.boolean "customerCustomFields__fix_relational_custom_fields__", comment: "A work-around needed when only relational custom fields are defined on an entity"
    t.index ["customerUserid"], name: "REL_618643728bd0f9786a0741717c", unique: true
  end

  create_table "fcm_token_customer_channels_channel", primary_key: ["fcmTokenId", "fcmTokenCustomerId", "channelId"], force: :cascade do |t|
    t.integer "fcmTokenId", null: false
    t.integer "fcmTokenCustomerId", null: false
    t.integer "channelId", null: false
    t.index ["channelId"], name: "IDX_40d71aa229db7f73416e8408de"
    t.index ["fcmTokenId", "fcmTokenCustomerId"], name: "IDX_607749d57dde3efc2679318127"
  end

  create_table "fcm_token_customer_custom_fields_notification_notification_item", primary_key: ["fcmTokenId", "fcmTokenCustomerId", "notificationItemId"], force: :cascade do |t|
    t.integer "fcmTokenId", null: false
    t.integer "fcmTokenCustomerId", null: false
    t.integer "notificationItemId", null: false
    t.index ["fcmTokenId", "fcmTokenCustomerId"], name: "IDX_89b9df11c67bdc34b9bb1b588e"
    t.index ["notificationItemId"], name: "IDX_9b7bef537a32b7b71722f4244b"
  end

  create_table "fcm_token_customer_groups_customer_group", primary_key: ["fcmTokenId", "fcmTokenCustomerId", "customerGroupId"], force: :cascade do |t|
    t.integer "fcmTokenId", null: false
    t.integer "fcmTokenCustomerId", null: false
    t.integer "customerGroupId", null: false
    t.index ["customerGroupId"], name: "IDX_dae79d005ba5bd8aadcdd77ecf"
    t.index ["fcmTokenId", "fcmTokenCustomerId"], name: "IDX_c608e880f0d8a9906fae51e091"
  end

  create_table "folders", force: :cascade do |t|
    t.integer "account_id", null: false
    t.integer "category_id", null: false
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "fulfillment", id: :serial, force: :cascade do |t|
    t.datetime "createdAt", precision: nil, default: -> { "now()" }, null: false
    t.datetime "updatedAt", precision: nil, default: -> { "now()" }, null: false
    t.string "state", null: false
    t.string "trackingCode", default: "", null: false
    t.string "method", null: false
    t.string "handlerCode", null: false
  end

  create_table "global_settings", id: :serial, force: :cascade do |t|
    t.datetime "createdAt", precision: nil, default: -> { "now()" }, null: false
    t.datetime "updatedAt", precision: nil, default: -> { "now()" }, null: false
    t.text "availableLanguages", null: false
    t.boolean "trackInventory", default: true, null: false
    t.integer "outOfStockThreshold", default: 0, null: false
  end

  create_table "history_entry", id: :serial, force: :cascade do |t|
    t.datetime "createdAt", precision: nil, default: -> { "now()" }, null: false
    t.datetime "updatedAt", precision: nil, default: -> { "now()" }, null: false
    t.string "type", null: false
    t.boolean "isPublic", null: false
    t.text "data", null: false
    t.string "discriminator", null: false
    t.integer "administratorId"
    t.integer "customerId"
    t.integer "orderId"
    t.index ["administratorId"], name: "IDX_92f8c334ef06275f9586fd0183"
    t.index ["customerId"], name: "IDX_43ac602f839847fdb91101f30e"
    t.index ["discriminator"], name: "IDX_f3a761f6bcfabb474b11e1e51f"
    t.index ["orderId"], name: "IDX_3a05127e67435b4d2332ded7c9"
  end

  create_table "inbox_members", id: :serial, force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "inbox_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["inbox_id", "user_id"], name: "index_inbox_members_on_inbox_id_and_user_id", unique: true
    t.index ["inbox_id"], name: "index_inbox_members_on_inbox_id"
  end

  create_table "inboxes", id: :serial, force: :cascade do |t|
    t.integer "channel_id", null: false
    t.integer "account_id", null: false
    t.string "name", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "channel_type"
    t.boolean "enable_auto_assignment", default: true
    t.boolean "greeting_enabled", default: false
    t.string "greeting_message"
    t.string "email_address"
    t.boolean "working_hours_enabled", default: false
    t.string "out_of_office_message"
    t.string "timezone", default: "UTC"
    t.boolean "enable_email_collect", default: true
    t.boolean "csat_survey_enabled", default: false
    t.boolean "allow_messages_after_resolved", default: true
    t.jsonb "auto_assignment_config", default: {}
    t.boolean "lock_to_single_conversation", default: false, null: false
    t.bigint "portal_id"
    t.integer "sender_name_type", default: 0, null: false
    t.string "business_name"
    t.index ["account_id"], name: "index_inboxes_on_account_id"
    t.index ["channel_id", "channel_type"], name: "index_inboxes_on_channel_id_and_channel_type"
    t.index ["portal_id"], name: "index_inboxes_on_portal_id"
  end

  create_table "installation_configs", force: :cascade do |t|
    t.string "name", null: false
    t.jsonb "serialized_value", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "locked", default: true, null: false
    t.index ["name", "created_at"], name: "index_installation_configs_on_name_and_created_at", unique: true
    t.index ["name"], name: "index_installation_configs_on_name", unique: true
  end

  create_table "integrations_hooks", force: :cascade do |t|
    t.integer "status", default: 1
    t.integer "inbox_id"
    t.integer "account_id"
    t.string "app_id"
    t.integer "hook_type", default: 0
    t.string "reference_id"
    t.string "access_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "settings", default: {}
  end

  create_table "job_record", id: :serial, force: :cascade do |t|
    t.datetime "createdAt", precision: nil, default: -> { "now()" }, null: false
    t.datetime "updatedAt", precision: nil, default: -> { "now()" }, null: false
    t.string "queueName", null: false
    t.text "data"
    t.string "state", null: false
    t.integer "progress", null: false
    t.text "result"
    t.string "error"
    t.datetime "startedAt"
    t.datetime "settledAt"
    t.boolean "isSettled", null: false
    t.integer "retries", null: false
    t.integer "attempts", null: false
  end

  create_table "job_record_buffer", id: :serial, force: :cascade do |t|
    t.datetime "createdAt", precision: nil, default: -> { "now()" }, null: false
    t.datetime "updatedAt", precision: nil, default: -> { "now()" }, null: false
    t.string "bufferId", null: false
    t.text "job", null: false
  end

  create_table "labels", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "color", default: "#1f93ff", null: false
    t.boolean "show_on_sidebar"
    t.bigint "account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_labels_on_account_id"
    t.index ["title", "account_id"], name: "index_labels_on_title_and_account_id", unique: true
  end

  create_table "macros", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.string "name", null: false
    t.integer "visibility", default: 0
    t.bigint "created_by_id"
    t.bigint "updated_by_id"
    t.jsonb "actions", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_macros_on_account_id"
  end

  create_table "mentions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "conversation_id", null: false
    t.bigint "account_id", null: false
    t.datetime "mentioned_at", precision: nil, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_mentions_on_account_id"
    t.index ["conversation_id"], name: "index_mentions_on_conversation_id"
    t.index ["user_id", "conversation_id"], name: "index_mentions_on_user_id_and_conversation_id", unique: true
    t.index ["user_id"], name: "index_mentions_on_user_id"
  end

  create_table "messages", id: :serial, force: :cascade do |t|
    t.text "content"
    t.integer "account_id", null: false
    t.integer "inbox_id", null: false
    t.integer "conversation_id", null: false
    t.integer "message_type", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.boolean "private", default: false, null: false
    t.integer "status", default: 0
    t.string "source_id"
    t.integer "content_type", default: 0, null: false
    t.json "content_attributes", default: {}
    t.string "sender_type"
    t.bigint "sender_id"
    t.jsonb "external_source_ids", default: {}
    t.jsonb "additional_attributes", default: {}
    t.text "processed_message_content"
    t.jsonb "sentiment", default: {}
    t.index "((additional_attributes -> 'campaign_id'::text))", name: "index_messages_on_additional_attributes_campaign_id", using: :gin
    t.index ["account_id", "inbox_id"], name: "index_messages_on_account_id_and_inbox_id"
    t.index ["account_id"], name: "index_messages_on_account_id"
    t.index ["content"], name: "index_messages_on_content", opclass: :gin_trgm_ops, using: :gin
    t.index ["conversation_id", "account_id", "message_type", "created_at"], name: "index_messages_on_conversation_account_type_created"
    t.index ["conversation_id"], name: "index_messages_on_conversation_id"
    t.index ["created_at"], name: "index_messages_on_created_at"
    t.index ["inbox_id"], name: "index_messages_on_inbox_id"
    t.index ["sender_type", "sender_id"], name: "index_messages_on_sender_type_and_sender_id"
    t.index ["source_id"], name: "index_messages_on_source_id"
  end

  create_table "migrations", id: :serial, force: :cascade do |t|
    t.bigint "timestamp", null: false
    t.string "name", null: false
  end

  create_table "notes", force: :cascade do |t|
    t.text "content", null: false
    t.bigint "account_id", null: false
    t.bigint "contact_id", null: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_notes_on_account_id"
    t.index ["contact_id"], name: "index_notes_on_contact_id"
    t.index ["user_id"], name: "index_notes_on_user_id"
  end

  create_table "notification_item", id: :serial, force: :cascade do |t|
    t.datetime "createdAt", precision: nil, default: -> { "now()" }, null: false
    t.datetime "updatedAt", precision: nil, default: -> { "now()" }, null: false
    t.string "title", null: false
    t.string "message", null: false
  end

  create_table "notification_item_customer_customer", primary_key: ["notificationItemId", "customerId"], force: :cascade do |t|
    t.integer "notificationItemId", null: false
    t.integer "customerId", null: false
    t.index ["customerId"], name: "IDX_d6219175609739b6bd6c61f85b"
    t.index ["notificationItemId"], name: "IDX_57d68c41f047be3430d4f8901d"
  end

  create_table "notification_settings", force: :cascade do |t|
    t.integer "account_id"
    t.integer "user_id"
    t.integer "email_flags", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "push_flags", default: 0, null: false
    t.index ["account_id", "user_id"], name: "by_account_user", unique: true
  end

  create_table "notification_subscriptions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "subscription_type", null: false
    t.jsonb "subscription_attributes", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "identifier"
    t.index ["identifier"], name: "index_notification_subscriptions_on_identifier", unique: true
    t.index ["user_id"], name: "index_notification_subscriptions_on_user_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "user_id", null: false
    t.integer "notification_type", null: false
    t.string "primary_actor_type", null: false
    t.bigint "primary_actor_id", null: false
    t.string "secondary_actor_type"
    t.bigint "secondary_actor_id"
    t.datetime "read_at", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_notifications_on_account_id"
    t.index ["primary_actor_type", "primary_actor_id"], name: "uniq_primary_actor_per_account_notifications"
    t.index ["secondary_actor_type", "secondary_actor_id"], name: "uniq_secondary_actor_per_account_notifications"
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "order", id: :serial, force: :cascade do |t|
    t.datetime "createdAt", precision: nil, default: -> { "now()" }, null: false
    t.datetime "updatedAt", precision: nil, default: -> { "now()" }, null: false
    t.string "type", default: "Regular", null: false
    t.string "code", null: false
    t.string "state", null: false
    t.boolean "active", default: true, null: false
    t.datetime "orderPlacedAt", precision: nil
    t.text "couponCodes", null: false
    t.text "shippingAddress", null: false
    t.text "billingAddress", null: false
    t.string "currencyCode", null: false
    t.integer "aggregateOrderId"
    t.integer "customerId"
    t.integer "taxZoneId"
    t.integer "subTotal", null: false
    t.integer "subTotalWithTax", null: false
    t.integer "shipping", default: 0, null: false
    t.integer "shippingWithTax", default: 0, null: false
    t.index ["aggregateOrderId"], name: "IDX_73a78d7df09541ac5eba620d18"
    t.index ["code"], name: "IDX_729b3eea7ce540930dbb706949", unique: true
    t.index ["customerId"], name: "IDX_124456e637cca7a415897dce65"
  end

  create_table "order_channels_channel", primary_key: ["orderId", "channelId"], force: :cascade do |t|
    t.integer "orderId", null: false
    t.integer "channelId", null: false
    t.index ["channelId"], name: "IDX_d0d16db872499e83b15999f8c7"
    t.index ["orderId"], name: "IDX_0d8e5c204480204a60e151e485"
  end

  create_table "order_fulfillments_fulfillment", primary_key: ["orderId", "fulfillmentId"], force: :cascade do |t|
    t.integer "orderId", null: false
    t.integer "fulfillmentId", null: false
    t.index ["fulfillmentId"], name: "IDX_4add5a5796e1582dec2877b289"
    t.index ["orderId"], name: "IDX_f80d84d525af2ffe974e7e8ca2"
  end

  create_table "order_line", id: :serial, force: :cascade do |t|
    t.datetime "createdAt", precision: nil, default: -> { "now()" }, null: false
    t.datetime "updatedAt", precision: nil, default: -> { "now()" }, null: false
    t.integer "quantity", null: false
    t.integer "orderPlacedQuantity", default: 0, null: false
    t.boolean "listPriceIncludesTax", null: false
    t.text "adjustments", null: false
    t.text "taxLines", null: false
    t.integer "sellerChannelId"
    t.integer "shippingLineId"
    t.integer "productVariantId", null: false
    t.integer "initialListPrice"
    t.integer "listPrice", null: false
    t.integer "taxCategoryId"
    t.integer "featuredAssetId"
    t.integer "orderId"
    t.index ["featuredAssetId"], name: "IDX_9f065453910ea77d4be8e92618"
    t.index ["orderId"], name: "IDX_239cfca2a55b98b90b6bef2e44"
    t.index ["productVariantId"], name: "IDX_cbcd22193eda94668e84d33f18"
    t.index ["sellerChannelId"], name: "IDX_6901d8715f5ebadd764466f7bd"
    t.index ["shippingLineId"], name: "IDX_dc9ac68b47da7b62249886affb"
    t.index ["taxCategoryId"], name: "IDX_77be94ce9ec650446617946227"
  end

  create_table "order_line_reference", id: :serial, force: :cascade do |t|
    t.datetime "createdAt", precision: nil, default: -> { "now()" }, null: false
    t.datetime "updatedAt", precision: nil, default: -> { "now()" }, null: false
    t.integer "quantity", null: false
    t.integer "fulfillmentId"
    t.integer "modificationId"
    t.integer "orderLineId", null: false
    t.integer "refundId"
    t.string "discriminator", null: false
    t.index ["discriminator"], name: "IDX_49a8632be8cef48b076446b8b9"
    t.index ["fulfillmentId"], name: "IDX_06b02fb482b188823e419d37bd"
    t.index ["modificationId"], name: "IDX_22b818af8722746fb9f206068c"
    t.index ["orderLineId"], name: "IDX_7d57857922dfc7303604697dbe"
    t.index ["refundId"], name: "IDX_30019aa65b17fe9ee962893199"
  end

  create_table "order_modification", id: :serial, force: :cascade do |t|
    t.datetime "createdAt", precision: nil, default: -> { "now()" }, null: false
    t.datetime "updatedAt", precision: nil, default: -> { "now()" }, null: false
    t.string "note", null: false
    t.text "shippingAddressChange"
    t.text "billingAddressChange"
    t.integer "priceChange", null: false
    t.integer "orderId"
    t.integer "paymentId"
    t.integer "refundId"
    t.index ["orderId"], name: "IDX_1df5bc14a47ef24d2e681f4559"
    t.index ["paymentId"], name: "REL_ad2991fa2933ed8b7f86a71633", unique: true
    t.index ["refundId"], name: "REL_cb66b63b6e97613013795eadbd", unique: true
  end

  create_table "order_promotions_promotion", primary_key: ["orderId", "promotionId"], force: :cascade do |t|
    t.integer "orderId", null: false
    t.integer "promotionId", null: false
    t.index ["orderId"], name: "IDX_67be0e40122ab30a62a9817efe"
    t.index ["promotionId"], name: "IDX_2c26b988769c0e3b0120bdef31"
  end

  create_table "payment", id: :serial, force: :cascade do |t|
    t.datetime "createdAt", precision: nil, default: -> { "now()" }, null: false
    t.datetime "updatedAt", precision: nil, default: -> { "now()" }, null: false
    t.string "method", null: false
    t.string "state", null: false
    t.string "errorMessage"
    t.string "transactionId"
    t.text "metadata", null: false
    t.integer "amount", null: false
    t.integer "orderId"
    t.index ["orderId"], name: "IDX_d09d285fe1645cd2f0db811e29"
  end

  create_table "payment_method", id: :serial, force: :cascade do |t|
    t.datetime "createdAt", precision: nil, default: -> { "now()" }, null: false
    t.datetime "updatedAt", precision: nil, default: -> { "now()" }, null: false
    t.string "code", default: "", null: false
    t.boolean "enabled", null: false
    t.text "checker"
    t.text "handler", null: false
  end

  create_table "payment_method_channels_channel", primary_key: ["paymentMethodId", "channelId"], force: :cascade do |t|
    t.integer "paymentMethodId", null: false
    t.integer "channelId", null: false
    t.index ["channelId"], name: "IDX_c00e36f667d35031087b382e61"
    t.index ["paymentMethodId"], name: "IDX_5bcb569635ce5407eb3f264487"
  end

  create_table "payment_method_translation", id: :serial, force: :cascade do |t|
    t.datetime "createdAt", precision: nil, default: -> { "now()" }, null: false
    t.datetime "updatedAt", precision: nil, default: -> { "now()" }, null: false
    t.string "languageCode", null: false
    t.string "name", null: false
    t.text "description", null: false
    t.integer "baseId"
    t.index ["baseId"], name: "IDX_66187f782a3e71b9e0f5b50b68"
  end

  create_table "platform_app_permissibles", force: :cascade do |t|
    t.bigint "platform_app_id", null: false
    t.string "permissible_type", null: false
    t.bigint "permissible_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["permissible_type", "permissible_id"], name: "index_platform_app_permissibles_on_permissibles"
    t.index ["platform_app_id", "permissible_id", "permissible_type"], name: "unique_permissibles_index", unique: true
    t.index ["platform_app_id"], name: "index_platform_app_permissibles_on_platform_app_id"
  end

  create_table "platform_apps", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "portal_members", force: :cascade do |t|
    t.bigint "portal_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["portal_id", "user_id"], name: "index_portal_members_on_portal_id_and_user_id", unique: true
    t.index ["user_id", "portal_id"], name: "index_portal_members_on_user_id_and_portal_id", unique: true
  end

  create_table "portals", force: :cascade do |t|
    t.integer "account_id", null: false
    t.string "name", null: false
    t.string "slug", null: false
    t.string "custom_domain"
    t.string "color"
    t.string "homepage_link"
    t.string "page_title"
    t.text "header_text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "config", default: {"allowed_locales"=>["en"]}
    t.boolean "archived", default: false
    t.index ["custom_domain"], name: "index_portals_on_custom_domain", unique: true
    t.index ["slug"], name: "index_portals_on_slug", unique: true
  end

  create_table "portals_members", id: false, force: :cascade do |t|
    t.bigint "portal_id", null: false
    t.bigint "user_id", null: false
    t.index ["portal_id", "user_id"], name: "index_portals_members_on_portal_id_and_user_id", unique: true
    t.index ["portal_id"], name: "index_portals_members_on_portal_id"
    t.index ["user_id"], name: "index_portals_members_on_user_id"
  end

  create_table "product", id: :serial, force: :cascade do |t|
    t.datetime "createdAt", precision: nil, default: -> { "now()" }, null: false
    t.datetime "updatedAt", precision: nil, default: -> { "now()" }, null: false
    t.datetime "deletedAt", precision: nil
    t.boolean "enabled", default: true, null: false
    t.integer "featuredAssetId"
    t.index ["featuredAssetId"], name: "IDX_91a19e6613534949a4ce6e76ff"
  end

  create_table "product_asset", id: :serial, force: :cascade do |t|
    t.datetime "createdAt", precision: nil, default: -> { "now()" }, null: false
    t.datetime "updatedAt", precision: nil, default: -> { "now()" }, null: false
    t.integer "assetId", null: false
    t.integer "position", null: false
    t.integer "productId", null: false
    t.index ["assetId"], name: "IDX_5888ac17b317b93378494a1062"
    t.index ["productId"], name: "IDX_0d1294f5c22a56da7845ebab72"
  end

  create_table "product_channels_channel", primary_key: ["productId", "channelId"], force: :cascade do |t|
    t.integer "productId", null: false
    t.integer "channelId", null: false
    t.index ["channelId"], name: "IDX_a51dfbd87c330c075c39832b6e"
    t.index ["productId"], name: "IDX_26d12be3b5fec6c4adb1d79284"
  end

  create_table "product_facet_values_facet_value", primary_key: ["productId", "facetValueId"], force: :cascade do |t|
    t.integer "productId", null: false
    t.integer "facetValueId", null: false
    t.index ["facetValueId"], name: "IDX_06e7d73673ee630e8ec50d0b29"
    t.index ["productId"], name: "IDX_6a0558e650d75ae639ff38e413"
  end

  create_table "product_option", id: :serial, force: :cascade do |t|
    t.datetime "createdAt", precision: nil, default: -> { "now()" }, null: false
    t.datetime "updatedAt", precision: nil, default: -> { "now()" }, null: false
    t.datetime "deletedAt", precision: nil
    t.string "code", null: false
    t.integer "groupId", null: false
    t.index ["groupId"], name: "IDX_a6debf9198e2fbfa006aa10d71"
  end

  create_table "product_option_group", id: :serial, force: :cascade do |t|
    t.datetime "createdAt", precision: nil, default: -> { "now()" }, null: false
    t.datetime "updatedAt", precision: nil, default: -> { "now()" }, null: false
    t.datetime "deletedAt", precision: nil
    t.string "code", null: false
    t.integer "productId"
    t.index ["productId"], name: "IDX_a6e91739227bf4d442f23c52c7"
  end

  create_table "product_option_group_translation", id: :serial, force: :cascade do |t|
    t.datetime "createdAt", precision: nil, default: -> { "now()" }, null: false
    t.datetime "updatedAt", precision: nil, default: -> { "now()" }, null: false
    t.string "languageCode", null: false
    t.string "name", null: false
    t.integer "baseId"
    t.index ["baseId"], name: "IDX_93751abc1451972c02e033b766"
  end

  create_table "product_option_translation", id: :serial, force: :cascade do |t|
    t.datetime "createdAt", precision: nil, default: -> { "now()" }, null: false
    t.datetime "updatedAt", precision: nil, default: -> { "now()" }, null: false
    t.string "languageCode", null: false
    t.string "name", null: false
    t.integer "baseId"
    t.index ["baseId"], name: "IDX_a79a443c1f7841f3851767faa6"
  end

  create_table "product_translation", id: :serial, force: :cascade do |t|
    t.datetime "createdAt", precision: nil, default: -> { "now()" }, null: false
    t.datetime "updatedAt", precision: nil, default: -> { "now()" }, null: false
    t.string "languageCode", null: false
    t.string "name", null: false
    t.string "slug", null: false
    t.text "description", null: false
    t.integer "baseId"
    t.index ["baseId"], name: "IDX_7dbc75cb4e8b002620c4dbfdac"
    t.index ["slug"], name: "IDX_f4a2ec16ba86d277b6faa0b67b"
  end

  create_table "product_variant", id: :serial, force: :cascade do |t|
    t.datetime "createdAt", precision: nil, default: -> { "now()" }, null: false
    t.datetime "updatedAt", precision: nil, default: -> { "now()" }, null: false
    t.datetime "deletedAt", precision: nil
    t.boolean "enabled", default: true, null: false
    t.string "sku", null: false
    t.integer "outOfStockThreshold", default: 0, null: false
    t.boolean "useGlobalOutOfStockThreshold", default: true, null: false
    t.string "trackInventory", default: "INHERIT", null: false
    t.integer "productId"
    t.integer "featuredAssetId"
    t.integer "taxCategoryId"
    t.index ["featuredAssetId"], name: "IDX_0e6f516053cf982b537836e21c"
    t.index ["productId"], name: "IDX_6e420052844edf3a5506d863ce"
    t.index ["taxCategoryId"], name: "IDX_e38dca0d82fd64c7cf8aac8b8e"
  end

  create_table "product_variant_asset", id: :serial, force: :cascade do |t|
    t.datetime "createdAt", precision: nil, default: -> { "now()" }, null: false
    t.datetime "updatedAt", precision: nil, default: -> { "now()" }, null: false
    t.integer "assetId", null: false
    t.integer "position", null: false
    t.integer "productVariantId", null: false
    t.index ["assetId"], name: "IDX_10b5a2e3dee0e30b1e26c32f5c"
    t.index ["productVariantId"], name: "IDX_fa21412afac15a2304f3eb35fe"
  end

  create_table "product_variant_channels_channel", primary_key: ["productVariantId", "channelId"], force: :cascade do |t|
    t.integer "productVariantId", null: false
    t.integer "channelId", null: false
    t.index ["channelId"], name: "IDX_d194bff171b62357688a5d0f55"
    t.index ["productVariantId"], name: "IDX_beeb2b3cd800e589f2213ae99d"
  end

  create_table "product_variant_facet_values_facet_value", primary_key: ["productVariantId", "facetValueId"], force: :cascade do |t|
    t.integer "productVariantId", null: false
    t.integer "facetValueId", null: false
    t.index ["facetValueId"], name: "IDX_0d641b761ed1dce4ef3cd33d55"
    t.index ["productVariantId"], name: "IDX_69567bc225b6bbbd732d6c5455"
  end

  create_table "product_variant_options_product_option", primary_key: ["productVariantId", "productOptionId"], force: :cascade do |t|
    t.integer "productVariantId", null: false
    t.integer "productOptionId", null: false
    t.index ["productOptionId"], name: "IDX_e96a71affe63c97f7fa2f076da"
    t.index ["productVariantId"], name: "IDX_526f0131260eec308a3bd2b61b"
  end

  create_table "product_variant_price", id: :serial, force: :cascade do |t|
    t.datetime "createdAt", precision: nil, default: -> { "now()" }, null: false
    t.datetime "updatedAt", precision: nil, default: -> { "now()" }, null: false
    t.string "currencyCode", null: false
    t.integer "channelId"
    t.integer "price", null: false
    t.integer "variantId"
    t.index ["variantId"], name: "IDX_e6126cd268aea6e9b31d89af9a"
  end

  create_table "product_variant_translation", id: :serial, force: :cascade do |t|
    t.datetime "createdAt", precision: nil, default: -> { "now()" }, null: false
    t.datetime "updatedAt", precision: nil, default: -> { "now()" }, null: false
    t.string "languageCode", null: false
    t.string "name", null: false
    t.integer "baseId"
    t.index ["baseId"], name: "IDX_420f4d6fb75d38b9dca79bc43b"
  end

  create_table "promotion", id: :serial, force: :cascade do |t|
    t.datetime "createdAt", precision: nil, default: -> { "now()" }, null: false
    t.datetime "updatedAt", precision: nil, default: -> { "now()" }, null: false
    t.datetime "deletedAt", precision: nil
    t.datetime "startsAt", precision: nil
    t.datetime "endsAt", precision: nil
    t.string "couponCode"
    t.integer "perCustomerUsageLimit"
    t.boolean "enabled", null: false
    t.text "conditions", null: false
    t.text "actions", null: false
    t.integer "priorityScore", null: false
  end

  create_table "promotion_channels_channel", primary_key: ["promotionId", "channelId"], force: :cascade do |t|
    t.integer "promotionId", null: false
    t.integer "channelId", null: false
    t.index ["channelId"], name: "IDX_0eaaf0f4b6c69afde1e88ffb52"
    t.index ["promotionId"], name: "IDX_6d9e2c39ab12391aaa374bcdaa"
  end

  create_table "promotion_translation", id: :serial, force: :cascade do |t|
    t.datetime "createdAt", precision: nil, default: -> { "now()" }, null: false
    t.datetime "updatedAt", precision: nil, default: -> { "now()" }, null: false
    t.string "languageCode", null: false
    t.string "name", null: false
    t.text "description", null: false
    t.integer "baseId"
    t.index ["baseId"], name: "IDX_1cc009e9ab2263a35544064561"
  end

  create_table "refund", id: :serial, force: :cascade do |t|
    t.datetime "createdAt", precision: nil, default: -> { "now()" }, null: false
    t.datetime "updatedAt", precision: nil, default: -> { "now()" }, null: false
    t.string "method", null: false
    t.string "reason"
    t.string "state", null: false
    t.string "transactionId"
    t.text "metadata", null: false
    t.integer "paymentId", null: false
    t.integer "items", null: false
    t.integer "shipping", null: false
    t.integer "adjustment", null: false
    t.integer "total", null: false
    t.index ["paymentId"], name: "IDX_1c6932a756108788a361e7d440"
  end

  create_table "region", id: :serial, force: :cascade do |t|
    t.datetime "createdAt", precision: nil, default: -> { "now()" }, null: false
    t.datetime "updatedAt", precision: nil, default: -> { "now()" }, null: false
    t.string "code", null: false
    t.string "type", null: false
    t.boolean "enabled", null: false
    t.integer "parentId"
    t.string "discriminator", null: false
    t.index ["parentId"], name: "IDX_ed0c8098ce6809925a437f42ae"
  end

  create_table "region_translation", id: :serial, force: :cascade do |t|
    t.datetime "createdAt", precision: nil, default: -> { "now()" }, null: false
    t.datetime "updatedAt", precision: nil, default: -> { "now()" }, null: false
    t.string "languageCode", null: false
    t.string "name", null: false
    t.integer "baseId"
    t.index ["baseId"], name: "IDX_1afd722b943c81310705fc3e61"
  end

  create_table "related_categories", force: :cascade do |t|
    t.bigint "category_id"
    t.bigint "related_category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id", "related_category_id"], name: "index_related_categories_on_category_id_and_related_category_id", unique: true
    t.index ["related_category_id", "category_id"], name: "index_related_categories_on_related_category_id_and_category_id", unique: true
  end

  create_table "reporting_events", force: :cascade do |t|
    t.string "name"
    t.float "value"
    t.integer "account_id"
    t.integer "inbox_id"
    t.integer "user_id"
    t.integer "conversation_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "value_in_business_hours"
    t.datetime "event_start_time", precision: nil
    t.datetime "event_end_time", precision: nil
    t.index ["account_id", "name", "created_at"], name: "reporting_events__account_id__name__created_at"
    t.index ["account_id"], name: "index_reporting_events_on_account_id"
    t.index ["conversation_id"], name: "index_reporting_events_on_conversation_id"
    t.index ["created_at"], name: "index_reporting_events_on_created_at"
    t.index ["inbox_id"], name: "index_reporting_events_on_inbox_id"
    t.index ["name"], name: "index_reporting_events_on_name"
    t.index ["user_id"], name: "index_reporting_events_on_user_id"
  end

  create_table "role", id: :serial, force: :cascade do |t|
    t.datetime "createdAt", precision: nil, default: -> { "now()" }, null: false
    t.datetime "updatedAt", precision: nil, default: -> { "now()" }, null: false
    t.string "code", null: false
    t.string "description", null: false
    t.text "permissions", null: false
  end

  create_table "role_channels_channel", primary_key: ["roleId", "channelId"], force: :cascade do |t|
    t.integer "roleId", null: false
    t.integer "channelId", null: false
    t.index ["channelId"], name: "IDX_e09dfee62b158307404202b43a"
    t.index ["roleId"], name: "IDX_bfd2a03e9988eda6a9d1176011"
  end

  create_table "search_index_item", primary_key: ["languageCode", "productVariantId", "channelId"], force: :cascade do |t|
    t.string "languageCode", null: false
    t.boolean "enabled", null: false
    t.string "productName", null: false
    t.string "productVariantName", null: false
    t.text "description", null: false
    t.string "slug", null: false
    t.string "sku", null: false
    t.text "facetIds", null: false
    t.text "facetValueIds", null: false
    t.text "collectionIds", null: false
    t.text "collectionSlugs", null: false
    t.text "channelIds", null: false
    t.string "productPreview", null: false
    t.text "productPreviewFocalPoint"
    t.string "productVariantPreview", null: false
    t.text "productVariantPreviewFocalPoint"
    t.boolean "inStock", default: true, null: false
    t.boolean "productInStock", default: true, null: false
    t.integer "productVariantId", null: false
    t.integer "channelId", null: false
    t.integer "productId", null: false
    t.integer "productAssetId"
    t.integer "productVariantAssetId"
    t.integer "price", null: false
    t.integer "priceWithTax", null: false
    t.index ["description"], name: "IDX_9a5a6a556f75c4ac7bfdd03410"
    t.index ["productName"], name: "IDX_6fb55742e13e8082954d0436dc"
    t.index ["productVariantName"], name: "IDX_d8791f444a8bf23fe4c1bc020c"
  end

  create_table "seller", id: :serial, force: :cascade do |t|
    t.datetime "createdAt", precision: nil, default: -> { "now()" }, null: false
    t.datetime "updatedAt", precision: nil, default: -> { "now()" }, null: false
    t.datetime "deletedAt", precision: nil
    t.string "name", null: false
  end

  create_table "session", id: :serial, force: :cascade do |t|
    t.datetime "createdAt", precision: nil, default: -> { "now()" }, null: false
    t.datetime "updatedAt", precision: nil, default: -> { "now()" }, null: false
    t.string "token", null: false
    t.datetime "expires", precision: nil, null: false
    t.boolean "invalidated", null: false
    t.string "authenticationStrategy"
    t.integer "activeOrderId"
    t.integer "activeChannelId"
    t.string "type", null: false
    t.integer "userId"
    t.index ["activeChannelId"], name: "IDX_eb87ef1e234444728138302263"
    t.index ["activeOrderId"], name: "IDX_7a75399a4f4ffa48ee02e98c05"
    t.index ["token"], name: "IDX_232f8e85d7633bd6ddfad42169", unique: true
    t.index ["type"], name: "IDX_e5598363000cab9d9116bd5835"
    t.index ["userId"], name: "IDX_3d2f174ef04fb312fdebd0ddc5"
  end

  create_table "shipping_line", id: :serial, force: :cascade do |t|
    t.datetime "createdAt", precision: nil, default: -> { "now()" }, null: false
    t.datetime "updatedAt", precision: nil, default: -> { "now()" }, null: false
    t.boolean "listPriceIncludesTax", null: false
    t.text "adjustments", null: false
    t.text "taxLines", null: false
    t.integer "shippingMethodId", null: false
    t.integer "listPrice", null: false
    t.integer "orderId"
    t.index ["orderId"], name: "IDX_c9f34a440d490d1b66f6829b86"
    t.index ["shippingMethodId"], name: "IDX_e2e7642e1e88167c1dfc827fdf"
  end

  create_table "shipping_method", id: :serial, force: :cascade do |t|
    t.datetime "createdAt", precision: nil, default: -> { "now()" }, null: false
    t.datetime "updatedAt", precision: nil, default: -> { "now()" }, null: false
    t.datetime "deletedAt", precision: nil
    t.string "code", null: false
    t.text "checker", null: false
    t.text "calculator", null: false
    t.string "fulfillmentHandlerCode", null: false
  end

  create_table "shipping_method_channels_channel", primary_key: ["shippingMethodId", "channelId"], force: :cascade do |t|
    t.integer "shippingMethodId", null: false
    t.integer "channelId", null: false
    t.index ["channelId"], name: "IDX_f2b98dfb56685147bed509acc3"
    t.index ["shippingMethodId"], name: "IDX_f0a17b94aa5a162f0d422920eb"
  end

  create_table "shipping_method_translation", id: :serial, force: :cascade do |t|
    t.datetime "createdAt", precision: nil, default: -> { "now()" }, null: false
    t.datetime "updatedAt", precision: nil, default: -> { "now()" }, null: false
    t.string "languageCode", null: false
    t.string "name", default: "", null: false
    t.string "description", default: "", null: false
    t.integer "baseId"
    t.index ["baseId"], name: "IDX_85ec26c71067ebc84adcd98d1a"
  end

  create_table "sla_policies", force: :cascade do |t|
    t.string "name", null: false
    t.float "frt_threshold"
    t.float "rt_threshold"
    t.boolean "only_during_business_hours", default: false
    t.bigint "account_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_sla_policies_on_account_id"
  end

  create_table "stock_level", id: :serial, force: :cascade do |t|
    t.datetime "createdAt", precision: nil, default: -> { "now()" }, null: false
    t.datetime "updatedAt", precision: nil, default: -> { "now()" }, null: false
    t.integer "stockOnHand", null: false
    t.integer "stockAllocated", null: false
    t.integer "productVariantId", null: false
    t.integer "stockLocationId", null: false
    t.index ["productVariantId", "stockLocationId"], name: "IDX_7fc20486b8cfd33dc84c96e168", unique: true
    t.index ["productVariantId"], name: "IDX_9950eae3180f39c71978748bd0"
    t.index ["stockLocationId"], name: "IDX_984c48572468c69661a0b7b049"
  end

  create_table "stock_location", id: :serial, force: :cascade do |t|
    t.datetime "createdAt", precision: nil, default: -> { "now()" }, null: false
    t.datetime "updatedAt", precision: nil, default: -> { "now()" }, null: false
    t.string "name", null: false
    t.string "description", null: false
  end

  create_table "stock_location_channels_channel", primary_key: ["stockLocationId", "channelId"], force: :cascade do |t|
    t.integer "stockLocationId", null: false
    t.integer "channelId", null: false
    t.index ["channelId"], name: "IDX_ff8150fe54e56a900d5712671a"
    t.index ["stockLocationId"], name: "IDX_39513fd02a573c848d23bee587"
  end

  create_table "stock_movement", id: :serial, force: :cascade do |t|
    t.datetime "createdAt", precision: nil, default: -> { "now()" }, null: false
    t.datetime "updatedAt", precision: nil, default: -> { "now()" }, null: false
    t.string "type", null: false
    t.integer "quantity", null: false
    t.integer "stockLocationId", null: false
    t.string "discriminator", null: false
    t.integer "productVariantId"
    t.integer "orderLineId"
    t.index ["discriminator"], name: "IDX_94e15d5f12d355d117390131ac"
    t.index ["orderLineId"], name: "IDX_d2c8d5fca981cc820131f81aa8"
    t.index ["productVariantId"], name: "IDX_e65ba3882557cab4febb54809b"
    t.index ["stockLocationId"], name: "IDX_a2fe7172eeae9f1cca86f8f573"
  end

  create_table "surcharge", id: :serial, force: :cascade do |t|
    t.datetime "createdAt", precision: nil, default: -> { "now()" }, null: false
    t.datetime "updatedAt", precision: nil, default: -> { "now()" }, null: false
    t.string "description", null: false
    t.boolean "listPriceIncludesTax", null: false
    t.string "sku", null: false
    t.text "taxLines", null: false
    t.integer "listPrice", null: false
    t.integer "orderId"
    t.integer "orderModificationId"
    t.index ["orderId"], name: "IDX_154eb685f9b629033bd266df7f"
    t.index ["orderModificationId"], name: "IDX_a49c5271c39cc8174a0535c808"
  end

  create_table "tag", id: :serial, force: :cascade do |t|
    t.datetime "createdAt", precision: nil, default: -> { "now()" }, null: false
    t.datetime "updatedAt", precision: nil, default: -> { "now()" }, null: false
    t.string "value", null: false
  end

  create_table "taggings", id: :serial, force: :cascade do |t|
    t.integer "tag_id"
    t.string "taggable_type"
    t.integer "taggable_id"
    t.string "tagger_type"
    t.integer "tagger_id"
    t.string "context", limit: 128
    t.datetime "created_at", precision: nil
    t.index ["context"], name: "index_taggings_on_context"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy"
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id"
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type"
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type"
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id"
  end

  create_table "tags", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "taggings_count", default: 0
    t.index "lower((name)::text) gin_trgm_ops", name: "tags_name_trgm_idx", using: :gin
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "tax_category", id: :serial, force: :cascade do |t|
    t.datetime "createdAt", precision: nil, default: -> { "now()" }, null: false
    t.datetime "updatedAt", precision: nil, default: -> { "now()" }, null: false
    t.string "name", null: false
    t.boolean "isDefault", default: false, null: false
  end

  create_table "tax_rate", id: :serial, force: :cascade do |t|
    t.datetime "createdAt", precision: nil, default: -> { "now()" }, null: false
    t.datetime "updatedAt", precision: nil, default: -> { "now()" }, null: false
    t.string "name", null: false
    t.boolean "enabled", null: false
    t.decimal "value", precision: 5, scale: 2, null: false
    t.integer "categoryId"
    t.integer "zoneId"
    t.integer "customerGroupId"
    t.index ["categoryId"], name: "IDX_7ee3306d7638aa85ca90d67219"
    t.index ["customerGroupId"], name: "IDX_8b5ab52fc8887c1a769b9276ca"
    t.index ["zoneId"], name: "IDX_9872fc7de2f4e532fd3230d191"
  end

  create_table "team_members", force: :cascade do |t|
    t.bigint "team_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id", "user_id"], name: "index_team_members_on_team_id_and_user_id", unique: true
    t.index ["team_id"], name: "index_team_members_on_team_id"
    t.index ["user_id"], name: "index_team_members_on_user_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.boolean "allow_auto_assign", default: true
    t.bigint "account_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_teams_on_account_id"
    t.index ["name", "account_id"], name: "index_teams_on_name_and_account_id", unique: true
  end

  create_table "telegram_bots", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "auth_key"
    t.integer "account_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "user", id: :serial, force: :cascade do |t|
    t.datetime "createdAt", precision: nil, default: -> { "now()" }, null: false
    t.datetime "updatedAt", precision: nil, default: -> { "now()" }, null: false
    t.datetime "deletedAt", precision: nil
    t.string "identifier", null: false
    t.boolean "verified", default: false, null: false
    t.datetime "lastLogin", precision: nil
  end

  create_table "user_roles_role", primary_key: ["userId", "roleId"], force: :cascade do |t|
    t.integer "userId", null: false
    t.integer "roleId", null: false
    t.index ["roleId"], name: "IDX_4be2f7adf862634f5f803d246b"
    t.index ["userId"], name: "IDX_5f9286e6c25594c6b88c108db7"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: nil
    t.datetime "remember_created_at", precision: nil
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at", precision: nil
    t.datetime "last_sign_in_at", precision: nil
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at", precision: nil
    t.datetime "confirmation_sent_at", precision: nil
    t.string "unconfirmed_email"
    t.string "name", null: false
    t.string "display_name"
    t.string "email"
    t.json "tokens"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "pubsub_token"
    t.integer "availability", default: 0
    t.jsonb "ui_settings", default: {}
    t.jsonb "custom_attributes", default: {}
    t.string "type"
    t.text "message_signature"
    t.index ["email"], name: "index_users_on_email"
    t.index ["pubsub_token"], name: "index_users_on_pubsub_token", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  create_table "webhooks", force: :cascade do |t|
    t.integer "account_id"
    t.integer "inbox_id"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "webhook_type", default: 0
    t.jsonb "subscriptions", default: ["conversation_status_changed", "conversation_updated", "conversation_created", "contact_created", "contact_updated", "message_created", "message_updated", "webwidget_triggered"]
    t.index ["account_id", "url"], name: "index_webhooks_on_account_id_and_url", unique: true
  end

  create_table "working_hours", force: :cascade do |t|
    t.bigint "inbox_id"
    t.bigint "account_id"
    t.integer "day_of_week", null: false
    t.boolean "closed_all_day", default: false
    t.integer "open_hour"
    t.integer "open_minutes"
    t.integer "close_hour"
    t.integer "close_minutes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "open_all_day", default: false
    t.index ["account_id"], name: "index_working_hours_on_account_id"
    t.index ["inbox_id"], name: "index_working_hours_on_inbox_id"
  end

  create_table "zone", id: :serial, force: :cascade do |t|
    t.datetime "createdAt", precision: nil, default: -> { "now()" }, null: false
    t.datetime "updatedAt", precision: nil, default: -> { "now()" }, null: false
    t.string "name", null: false
  end

  create_table "zone_members_region", primary_key: ["zoneId", "regionId"], force: :cascade do |t|
    t.integer "zoneId", null: false
    t.integer "regionId", null: false
    t.index ["regionId"], name: "IDX_b45b65256486a15a104e17d495"
    t.index ["zoneId"], name: "IDX_433f45158e4e2b2a2f344714b2"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "address", "customer", column: "customerId", name: "FK_dc34d382b493ade1f70e834c4d3"
  add_foreign_key "address", "region", column: "countryId", name: "FK_d87215343c3a3a67e6a0b7f3ea9"
  add_foreign_key "administrator", "user", column: "userId", name: "FK_1966e18ce6a39a82b19204704d7"
  add_foreign_key "asset_channels_channel", "asset", column: "assetId", name: "FK_dc4e7435f9f5e9e6436bebd33bb", on_update: :cascade, on_delete: :cascade
  add_foreign_key "asset_channels_channel", "channel", column: "channelId", name: "FK_16ca9151a5153f1169da5b7b7e3", on_update: :cascade, on_delete: :cascade
  add_foreign_key "asset_tags_tag", "asset", column: "assetId", name: "FK_9e412b00d4c6cee1a4b3d920716", on_update: :cascade, on_delete: :cascade
  add_foreign_key "asset_tags_tag", "tag", column: "tagId", name: "FK_fb5e800171ffbe9823f2cc727fd", on_update: :cascade, on_delete: :cascade
  add_foreign_key "authentication_method", "user", column: "userId", name: "FK_00cbe87bc0d4e36758d61bd31d6"
  add_foreign_key "channel", "seller", column: "sellerId", name: "FK_af2116c7e176b6b88dceceeb74b"
  add_foreign_key "channel", "zone", column: "defaultShippingZoneId", name: "FK_c9ca2f58d4517460435cbd8b4c9"
  add_foreign_key "channel", "zone", column: "defaultTaxZoneId", name: "FK_afe9f917a1c82b9e9e69f7c6129"
  add_foreign_key "collection", "asset", column: "featuredAssetId", name: "FK_7256fef1bb42f1b38156b7449f5", on_delete: :nullify
  add_foreign_key "collection", "collection", column: "parentId", name: "FK_4257b61275144db89fa0f5dc059"
  add_foreign_key "collection_asset", "asset", column: "assetId", name: "FK_51da53b26522dc0525762d2de8e", on_delete: :cascade
  add_foreign_key "collection_asset", "collection", column: "collectionId", name: "FK_1ed9e48dfbf74b5fcbb35d3d686", on_delete: :cascade
  add_foreign_key "collection_channels_channel", "channel", column: "channelId", name: "FK_7216ab24077cf5cbece7857dbbd", on_update: :cascade, on_delete: :cascade
  add_foreign_key "collection_channels_channel", "collection", column: "collectionId", name: "FK_cdbf33ffb5d4519161251520083", on_update: :cascade, on_delete: :cascade
  add_foreign_key "collection_closure", "collection", column: "id_ancestor", name: "FK_c309f8cd152bbeaea08491e0c66", on_delete: :cascade
  add_foreign_key "collection_closure", "collection", column: "id_descendant", name: "FK_457784c710f8ac9396010441f6c", on_delete: :cascade
  add_foreign_key "collection_product_variants_product_variant", "collection", column: "collectionId", name: "FK_6faa7b72422d9c4679e2f186ad1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "collection_product_variants_product_variant", "product_variant", column: "productVariantId", name: "FK_fb05887e2867365f236d7dd95ee"
  add_foreign_key "collection_translation", "collection", column: "baseId", name: "FK_e329f9036210d75caa1d8f2154a", on_delete: :cascade
  add_foreign_key "customer", "user", column: "userId", name: "FK_3f62b42ed23958b120c235f74df"
  add_foreign_key "customer_channels_channel", "channel", column: "channelId", name: "FK_dc9f69207a8867f83b0fd257e30", on_update: :cascade, on_delete: :cascade
  add_foreign_key "customer_channels_channel", "customer", column: "customerId", name: "FK_a842c9fe8cd4c8ff31402d172d7", on_update: :cascade, on_delete: :cascade
  add_foreign_key "customer_custom_fields_notification_notification_item", "customer", column: "customerId", name: "FK_abe895a39289ce0aae0e4818d3f", on_update: :cascade, on_delete: :cascade
  add_foreign_key "customer_custom_fields_notification_notification_item", "notification_item", column: "notificationItemId", name: "FK_d4919f7de35b4ab978507fcac25", on_update: :cascade, on_delete: :cascade
  add_foreign_key "customer_groups_customer_group", "customer", column: "customerId", name: "FK_b823a3c8bf3b78d3ed68736485c", on_update: :cascade, on_delete: :cascade
  add_foreign_key "customer_groups_customer_group", "customer_group", column: "customerGroupId", name: "FK_85feea3f0e5e82133605f78db02"
  add_foreign_key "facet_channels_channel", "channel", column: "channelId", name: "FK_2a8ea404d05bf682516184db7d3", on_update: :cascade, on_delete: :cascade
  add_foreign_key "facet_channels_channel", "facet", column: "facetId", name: "FK_ca796020c6d097e251e5d6d2b02", on_update: :cascade, on_delete: :cascade
  add_foreign_key "facet_translation", "facet", column: "baseId", name: "FK_eaea53f44bf9e97790d38a3d68f", on_delete: :cascade
  add_foreign_key "facet_value", "facet", column: "facetId", name: "FK_d101dc2265a7341be3d94968c5b", on_delete: :cascade
  add_foreign_key "facet_value_channels_channel", "channel", column: "channelId", name: "FK_e1d54c0b9db3e2eb17faaf5919c", on_update: :cascade, on_delete: :cascade
  add_foreign_key "facet_value_channels_channel", "facet_value", column: "facetValueId", name: "FK_ad690c1b05596d7f52e52ffeedd", on_update: :cascade, on_delete: :cascade
  add_foreign_key "facet_value_translation", "facet_value", column: "baseId", name: "FK_3d6e45823b65de808a66cb1423b", on_delete: :cascade
  add_foreign_key "fcm_token", "user", column: "customerUserid", name: "FK_618643728bd0f9786a0741717c6"
  add_foreign_key "fcm_token_customer_channels_channel", "channel", column: "channelId", name: "FK_40d71aa229db7f73416e8408de3", on_update: :cascade, on_delete: :cascade
  add_foreign_key "fcm_token_customer_channels_channel", "fcm_token", column: "fcmTokenId", name: "FK_607749d57dde3efc26793181279", on_update: :cascade, on_delete: :cascade
  add_foreign_key "fcm_token_customer_custom_fields_notification_notification_item", "fcm_token", column: "fcmTokenId", name: "FK_89b9df11c67bdc34b9bb1b588e5", on_update: :cascade, on_delete: :cascade
  add_foreign_key "fcm_token_customer_custom_fields_notification_notification_item", "notification_item", column: "notificationItemId", name: "FK_9b7bef537a32b7b71722f4244bd", on_update: :cascade, on_delete: :cascade
  add_foreign_key "fcm_token_customer_groups_customer_group", "customer_group", column: "customerGroupId", name: "FK_dae79d005ba5bd8aadcdd77ecfc"
  add_foreign_key "fcm_token_customer_groups_customer_group", "fcm_token", column: "fcmTokenId", name: "FK_c608e880f0d8a9906fae51e0915", on_update: :cascade, on_delete: :cascade
  add_foreign_key "history_entry", "administrator", column: "administratorId", name: "FK_92f8c334ef06275f9586fd01832"
  add_foreign_key "history_entry", "customer", column: "customerId", name: "FK_43ac602f839847fdb91101f30ec", on_delete: :cascade
  add_foreign_key "history_entry", "order", column: "orderId", name: "FK_3a05127e67435b4d2332ded7c9e", on_delete: :cascade
  add_foreign_key "inboxes", "portals"
  add_foreign_key "notification_item_customer_customer", "customer", column: "customerId", name: "FK_d6219175609739b6bd6c61f85b8"
  add_foreign_key "notification_item_customer_customer", "notification_item", column: "notificationItemId", name: "FK_57d68c41f047be3430d4f8901df", on_update: :cascade, on_delete: :cascade
  add_foreign_key "order", "customer", column: "customerId", name: "FK_124456e637cca7a415897dce659"
  add_foreign_key "order", "order", column: "aggregateOrderId", name: "FK_73a78d7df09541ac5eba620d181"
  add_foreign_key "order_channels_channel", "channel", column: "channelId", name: "FK_d0d16db872499e83b15999f8c7a", on_update: :cascade, on_delete: :cascade
  add_foreign_key "order_channels_channel", "order", column: "orderId", name: "FK_0d8e5c204480204a60e151e4853", on_update: :cascade, on_delete: :cascade
  add_foreign_key "order_fulfillments_fulfillment", "fulfillment", column: "fulfillmentId", name: "FK_4add5a5796e1582dec2877b2898", on_update: :cascade, on_delete: :cascade
  add_foreign_key "order_fulfillments_fulfillment", "order", column: "orderId", name: "FK_f80d84d525af2ffe974e7e8ca29", on_update: :cascade, on_delete: :cascade
  add_foreign_key "order_line", "asset", column: "featuredAssetId", name: "FK_9f065453910ea77d4be8e92618f"
  add_foreign_key "order_line", "channel", column: "sellerChannelId", name: "FK_6901d8715f5ebadd764466f7bde", on_delete: :nullify
  add_foreign_key "order_line", "order", column: "orderId", name: "FK_239cfca2a55b98b90b6bef2e44f", on_delete: :cascade
  add_foreign_key "order_line", "product_variant", column: "productVariantId", name: "FK_cbcd22193eda94668e84d33f185"
  add_foreign_key "order_line", "shipping_line", column: "shippingLineId", name: "FK_dc9ac68b47da7b62249886affba", on_delete: :nullify
  add_foreign_key "order_line", "tax_category", column: "taxCategoryId", name: "FK_77be94ce9ec6504466179462275"
  add_foreign_key "order_line_reference", "fulfillment", column: "fulfillmentId", name: "FK_06b02fb482b188823e419d37bd4"
  add_foreign_key "order_line_reference", "order_line", column: "orderLineId", name: "FK_7d57857922dfc7303604697dbe9", on_delete: :cascade
  add_foreign_key "order_line_reference", "order_modification", column: "modificationId", name: "FK_22b818af8722746fb9f206068c2"
  add_foreign_key "order_line_reference", "refund", column: "refundId", name: "FK_30019aa65b17fe9ee9628931991"
  add_foreign_key "order_modification", "order", column: "orderId", name: "FK_1df5bc14a47ef24d2e681f45598", on_delete: :cascade
  add_foreign_key "order_modification", "payment", column: "paymentId", name: "FK_ad2991fa2933ed8b7f86a716338"
  add_foreign_key "order_modification", "refund", column: "refundId", name: "FK_cb66b63b6e97613013795eadbd5"
  add_foreign_key "order_promotions_promotion", "order", column: "orderId", name: "FK_67be0e40122ab30a62a9817efe0", on_update: :cascade, on_delete: :cascade
  add_foreign_key "order_promotions_promotion", "promotion", column: "promotionId", name: "FK_2c26b988769c0e3b0120bdef31b", on_update: :cascade, on_delete: :cascade
  add_foreign_key "payment", "order", column: "orderId", name: "FK_d09d285fe1645cd2f0db811e293"
  add_foreign_key "payment_method_channels_channel", "channel", column: "channelId", name: "FK_c00e36f667d35031087b382e61b", on_update: :cascade, on_delete: :cascade
  add_foreign_key "payment_method_channels_channel", "payment_method", column: "paymentMethodId", name: "FK_5bcb569635ce5407eb3f264487d", on_update: :cascade, on_delete: :cascade
  add_foreign_key "payment_method_translation", "payment_method", column: "baseId", name: "FK_66187f782a3e71b9e0f5b50b68b", on_delete: :cascade
  add_foreign_key "product", "asset", column: "featuredAssetId", name: "FK_91a19e6613534949a4ce6e76ff8", on_delete: :nullify
  add_foreign_key "product_asset", "asset", column: "assetId", name: "FK_5888ac17b317b93378494a10620", on_delete: :cascade
  add_foreign_key "product_asset", "product", column: "productId", name: "FK_0d1294f5c22a56da7845ebab72c", on_delete: :cascade
  add_foreign_key "product_channels_channel", "channel", column: "channelId", name: "FK_a51dfbd87c330c075c39832b6e7", on_update: :cascade, on_delete: :cascade
  add_foreign_key "product_channels_channel", "product", column: "productId", name: "FK_26d12be3b5fec6c4adb1d792844", on_update: :cascade, on_delete: :cascade
  add_foreign_key "product_facet_values_facet_value", "facet_value", column: "facetValueId", name: "FK_06e7d73673ee630e8ec50d0b29f", on_update: :cascade, on_delete: :cascade
  add_foreign_key "product_facet_values_facet_value", "product", column: "productId", name: "FK_6a0558e650d75ae639ff38e413a", on_update: :cascade, on_delete: :cascade
  add_foreign_key "product_option", "product_option_group", column: "groupId", name: "FK_a6debf9198e2fbfa006aa10d710"
  add_foreign_key "product_option_group", "product", column: "productId", name: "FK_a6e91739227bf4d442f23c52c75"
  add_foreign_key "product_option_group_translation", "product_option_group", column: "baseId", name: "FK_93751abc1451972c02e033b766c", on_delete: :cascade
  add_foreign_key "product_option_translation", "product_option", column: "baseId", name: "FK_a79a443c1f7841f3851767faa6d", on_delete: :cascade
  add_foreign_key "product_translation", "product", column: "baseId", name: "FK_7dbc75cb4e8b002620c4dbfdac5"
  add_foreign_key "product_variant", "asset", column: "featuredAssetId", name: "FK_0e6f516053cf982b537836e21cf", on_delete: :nullify
  add_foreign_key "product_variant", "product", column: "productId", name: "FK_6e420052844edf3a5506d863ce6"
  add_foreign_key "product_variant", "tax_category", column: "taxCategoryId", name: "FK_e38dca0d82fd64c7cf8aac8b8ef"
  add_foreign_key "product_variant_asset", "asset", column: "assetId", name: "FK_10b5a2e3dee0e30b1e26c32f5c7", on_delete: :cascade
  add_foreign_key "product_variant_asset", "product_variant", column: "productVariantId", name: "FK_fa21412afac15a2304f3eb35feb", on_delete: :cascade
  add_foreign_key "product_variant_channels_channel", "channel", column: "channelId", name: "FK_d194bff171b62357688a5d0f559", on_update: :cascade, on_delete: :cascade
  add_foreign_key "product_variant_channels_channel", "product_variant", column: "productVariantId", name: "FK_beeb2b3cd800e589f2213ae99d6", on_update: :cascade, on_delete: :cascade
  add_foreign_key "product_variant_facet_values_facet_value", "facet_value", column: "facetValueId", name: "FK_0d641b761ed1dce4ef3cd33d559", on_update: :cascade, on_delete: :cascade
  add_foreign_key "product_variant_facet_values_facet_value", "product_variant", column: "productVariantId", name: "FK_69567bc225b6bbbd732d6c5455b", on_update: :cascade, on_delete: :cascade
  add_foreign_key "product_variant_options_product_option", "product_option", column: "productOptionId", name: "FK_e96a71affe63c97f7fa2f076dac", on_update: :cascade, on_delete: :cascade
  add_foreign_key "product_variant_options_product_option", "product_variant", column: "productVariantId", name: "FK_526f0131260eec308a3bd2b61b6", on_update: :cascade, on_delete: :cascade
  add_foreign_key "product_variant_price", "product_variant", column: "variantId", name: "FK_e6126cd268aea6e9b31d89af9ab", on_delete: :cascade
  add_foreign_key "product_variant_translation", "product_variant", column: "baseId", name: "FK_420f4d6fb75d38b9dca79bc43b4", on_delete: :cascade
  add_foreign_key "promotion_channels_channel", "channel", column: "channelId", name: "FK_0eaaf0f4b6c69afde1e88ffb52d", on_update: :cascade, on_delete: :cascade
  add_foreign_key "promotion_channels_channel", "promotion", column: "promotionId", name: "FK_6d9e2c39ab12391aaa374bcdaa4", on_update: :cascade, on_delete: :cascade
  add_foreign_key "promotion_translation", "promotion", column: "baseId", name: "FK_1cc009e9ab2263a35544064561b", on_delete: :cascade
  add_foreign_key "refund", "payment", column: "paymentId", name: "FK_1c6932a756108788a361e7d4404"
  add_foreign_key "region", "region", column: "parentId", name: "FK_ed0c8098ce6809925a437f42aec", on_delete: :nullify
  add_foreign_key "region_translation", "region", column: "baseId", name: "FK_1afd722b943c81310705fc3e612", on_delete: :cascade
  add_foreign_key "role_channels_channel", "channel", column: "channelId", name: "FK_e09dfee62b158307404202b43a5", on_update: :cascade, on_delete: :cascade
  add_foreign_key "role_channels_channel", "role", column: "roleId", name: "FK_bfd2a03e9988eda6a9d11760119", on_update: :cascade, on_delete: :cascade
  add_foreign_key "session", "channel", column: "activeChannelId", name: "FK_eb87ef1e234444728138302263b"
  add_foreign_key "session", "order", column: "activeOrderId", name: "FK_7a75399a4f4ffa48ee02e98c059"
  add_foreign_key "session", "user", column: "userId", name: "FK_3d2f174ef04fb312fdebd0ddc53"
  add_foreign_key "shipping_line", "order", column: "orderId", name: "FK_c9f34a440d490d1b66f6829b86c", on_delete: :cascade
  add_foreign_key "shipping_line", "shipping_method", column: "shippingMethodId", name: "FK_e2e7642e1e88167c1dfc827fdf3"
  add_foreign_key "shipping_method_channels_channel", "channel", column: "channelId", name: "FK_f2b98dfb56685147bed509acc3d", on_update: :cascade, on_delete: :cascade
  add_foreign_key "shipping_method_channels_channel", "shipping_method", column: "shippingMethodId", name: "FK_f0a17b94aa5a162f0d422920eb2", on_update: :cascade, on_delete: :cascade
  add_foreign_key "shipping_method_translation", "shipping_method", column: "baseId", name: "FK_85ec26c71067ebc84adcd98d1a5", on_delete: :cascade
  add_foreign_key "stock_level", "product_variant", column: "productVariantId", name: "FK_9950eae3180f39c71978748bd08", on_delete: :cascade
  add_foreign_key "stock_level", "stock_location", column: "stockLocationId", name: "FK_984c48572468c69661a0b7b0494", on_delete: :cascade
  add_foreign_key "stock_location_channels_channel", "channel", column: "channelId", name: "FK_ff8150fe54e56a900d5712671a0", on_update: :cascade, on_delete: :cascade
  add_foreign_key "stock_location_channels_channel", "stock_location", column: "stockLocationId", name: "FK_39513fd02a573c848d23bee587d", on_update: :cascade, on_delete: :cascade
  add_foreign_key "stock_movement", "order_line", column: "orderLineId", name: "FK_d2c8d5fca981cc820131f81aa83"
  add_foreign_key "stock_movement", "product_variant", column: "productVariantId", name: "FK_e65ba3882557cab4febb54809bb"
  add_foreign_key "stock_movement", "stock_location", column: "stockLocationId", name: "FK_a2fe7172eeae9f1cca86f8f573a", on_delete: :cascade
  add_foreign_key "surcharge", "order", column: "orderId", name: "FK_154eb685f9b629033bd266df7fa", on_delete: :cascade
  add_foreign_key "surcharge", "order_modification", column: "orderModificationId", name: "FK_a49c5271c39cc8174a0535c8088"
  add_foreign_key "tax_rate", "customer_group", column: "customerGroupId", name: "FK_8b5ab52fc8887c1a769b9276caf"
  add_foreign_key "tax_rate", "tax_category", column: "categoryId", name: "FK_7ee3306d7638aa85ca90d672198"
  add_foreign_key "tax_rate", "zone", column: "zoneId", name: "FK_9872fc7de2f4e532fd3230d1915"
  add_foreign_key "user_roles_role", "role", column: "roleId", name: "FK_4be2f7adf862634f5f803d246b8", on_update: :cascade, on_delete: :cascade
  add_foreign_key "user_roles_role", "user", column: "userId", name: "FK_5f9286e6c25594c6b88c108db77", on_update: :cascade, on_delete: :cascade
  add_foreign_key "zone_members_region", "region", column: "regionId", name: "FK_b45b65256486a15a104e17d495c", on_update: :cascade, on_delete: :cascade
  add_foreign_key "zone_members_region", "zone", column: "zoneId", name: "FK_433f45158e4e2b2a2f344714b22", on_update: :cascade, on_delete: :cascade
  create_trigger("accounts_after_insert_row_tr", :generated => true, :compatibility => 1).
      on("accounts").
      after(:insert).
      for_each(:row) do
    "execute format('create sequence IF NOT EXISTS conv_dpid_seq_%s', NEW.id);"
  end

  create_trigger("conversations_before_insert_row_tr", :generated => true, :compatibility => 1).
      on("conversations").
      before(:insert).
      for_each(:row) do
    "NEW.display_id := nextval('conv_dpid_seq_' || NEW.account_id);"
  end

  create_trigger("camp_dpid_before_insert", :generated => true, :compatibility => 1).
      on("accounts").
      name("camp_dpid_before_insert").
      after(:insert).
      for_each(:row) do
    "execute format('create sequence IF NOT EXISTS camp_dpid_seq_%s', NEW.id);"
  end

  create_trigger("campaigns_before_insert_row_tr", :generated => true, :compatibility => 1).
      on("campaigns").
      before(:insert).
      for_each(:row) do
    "NEW.display_id := nextval('camp_dpid_seq_' || NEW.account_id);"
  end

end
