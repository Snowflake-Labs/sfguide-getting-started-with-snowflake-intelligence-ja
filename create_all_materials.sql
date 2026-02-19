-------------------------------------------------------------------------
--  Step 2. Implement Cortex Analyst
-------------------------------------------------------------------------


USE ROLE SNOWFLAKE_INTELLIGENCE_ADMIN;
CALL SYSTEM$CREATE_SEMANTIC_VIEW_FROM_YAML(
  'DB_SI_JP.RETAIL',
  $$
name: Sales_And_Marketing_Data_BY_SQL
tables:
  - name: MARKETING_CAMPAIGN_METRICS
    base_table:
      database: DB_SI_JP
      schema: RETAIL
      table: MARKETING_CAMPAIGN_METRICS
    primary_key:
      columns:
        - CATEGORY
    dimensions:
      - name: CAMPAIGN_NAME
        synonyms:
          - ad_campaign
          - marketing_campaign
          - promo_name
          - advertisement_name
          - campaign_title
          - promotion_name
        description: マーケティングキャンペーンの名前。特定のプロモーション施策のパフォーマンスを識別・分析するために使用できます。
        expr: CAMPAIGN_NAME
        data_type: VARCHAR(16777216)
        sample_values:
          - Summer Fitness Campaign
      - name: CATEGORY
        synonyms:
          - type
          - classification
          - group
          - label
          - sector
          - class
          - kind
          - genre
        description: マーケティングキャンペーンのカテゴリ。プロモーション対象の製品またはサービスを表し、特定の業種や製品ラインなどを示します。
        expr: CATEGORY
        data_type: VARCHAR(16777216)
        sample_values:
          - Fitness Wear
    facts:
      - name: CLICKS
        synonyms:
          - click_throughs
          - link_clicks
          - ad_clicks
          - button_clicks
          - selections
          - hits
        description: マーケティングキャンペーンにおいて、ユーザーが広告またはプロモーションリンクをクリックした合計回数。
        expr: CLICKS
        data_type: NUMBER(38,0)
        sample_values:
          - '614'
          - '429'
          - '446'
      - name: IMPRESSIONS
        synonyms:
          - views
          - ad_views
          - ad_exposures
          - display_count
          - ad_impressions
          - exposures
          - ad_views_count
          - views_count
        description: マーケティングキャンペーン期間中に広告がユーザーに表示された合計回数。
        expr: IMPRESSIONS
        data_type: NUMBER(38,0)
        sample_values:
          - '10927'
          - '7278'
          - '9962'
    time_dimensions:
      - name: DATE
        synonyms:
          - day
          - calendar_date
          - timestamp
          - datestamp
          - calendar_day
          - date_value
        description: マーケティングキャンペーンの指標が記録された日付。
        expr: DATE
        data_type: DATE
        sample_values:
          - '2025-06-15'
          - '2025-06-16'
          - '2025-06-17'
  - name: PRODUCTS
    base_table:
      database: DB_SI_JP
      schema: RETAIL
      table: PRODUCTS
    primary_key:
      columns:
        - PRODUCT_ID
    dimensions:
      - name: CATEGORY
        synonyms:
          - type
          - classification
          - group
          - genre
          - kind
          - class
          - product_type
          - product_group
          - product_category
          - product_classification
        description: CATEGORYカラムは販売商品の種類を表し、Fitness Wear（フィットネスウェア）、Casual Wear（カジュアルウェア）、Accessories（アクセサリー）の3つの主要カテゴリに分類されます。
        expr: CATEGORY
        data_type: VARCHAR(16777216)
        sample_values:
          - Fitness Wear
          - Casual Wear
          - Accessories
      - name: PRODUCT_ID
        synonyms:
          - product_key
          - item_id
          - product_number
          - item_number
          - product_code
          - sku
          - product_identifier
        description: カタログ内の各商品を一意に識別するための識別子。
        expr: PRODUCT_ID
        data_type: NUMBER(38,0)
        sample_values:
          - '1'
          - '2'
          - '3'
      - name: PRODUCT_NAME
        synonyms:
          - item_name
          - product_title
          - item_title
          - product_description
          - product_label
          - item_label
        description: 販売商品の名称。フィットネス機器やアクセサリーなど、特定の商品タイプを示します。
        expr: PRODUCT_NAME
        data_type: VARCHAR(16777216)
        sample_values:
          - Fitness Item 1
          - Fitness Item 2
          - Fitness Item 3
  - name: SALES
    base_table:
      database: DB_SI_JP
      schema: RETAIL
      table: SALES
    dimensions:
      - name: PRODUCT_ID
        synonyms:
          - product_code
          - item_id
          - product_number
          - item_number
          - sku
          - product_key
        description: 販売商品の一意識別子。
        expr: PRODUCT_ID
        data_type: NUMBER(38,0)
        sample_values:
          - '1'
          - '2'
          - '3'
      - name: REGION
        synonyms:
          - area
          - territory
          - zone
          - district
          - location
          - province
          - state
          - county
          - geographic_area
          - market_area
        description: 販売が行われた地理的地域。
        expr: REGION
        data_type: VARCHAR(16777216)
        sample_values:
          - North
          - South
          - East
    facts:
      - name: SALES_AMOUNT
        synonyms:
          - total_sales
          - revenue
          - sales_total
          - sales_value
          - sales_revenue
          - total_revenue
          - sales_figure
          - sales_number
        description: 取引または注文によって生成された販売額の合計。
        expr: SALES_AMOUNT
        data_type: NUMBER(38,2)
        sample_values:
          - '2199.67'
          - '1039.35'
          - '692.70'
      - name: UNITS_SOLD
        synonyms:
          - quantity_sold
          - items_sold
          - sales_volume
          - units_purchased
          - volume_sold
          - sales_quantity
        description: 販売された商品の合計数量。
        expr: UNITS_SOLD
        data_type: NUMBER(38,0)
        sample_values:
          - '28'
          - '25'
          - '26'
    time_dimensions:
      - name: DATE
        synonyms:
          - day
          - calendar_date
          - date_field
          - calendar_day
          - timestamp
          - date_value
          - entry_date
          - record_date
          - log_date
        description: 販売が行われた日付。取引が発生したカレンダー日を表します。
        expr: DATE
        data_type: DATE
        sample_values:
          - '2025-05-16'
          - '2025-05-17'
          - '2025-05-18'
  - name: SOCIAL_MEDIA
    base_table:
      database: DB_SI_JP
      schema: RETAIL
      table: SOCIAL_MEDIA
    dimensions:
      - name: CATEGORY
        synonyms:
          - type
          - classification
          - group
          - genre
          - kind
          - label
          - section
          - class
        description: ソーシャルメディアコンテンツのカテゴリ。フィットネス関連の衣類やアクセサリーなど、プロモーション対象の製品またはサービスを示します。
        expr: CATEGORY
        data_type: VARCHAR(16777216)
        sample_values:
          - Fitness Wear
      - name: INFLUENCER
        synonyms:
          - social_media_personality
          - online_influencer
          - social_media_figure
          - content_creator
          - key_opinion_leader
          - thought_leader
          - industry_expert
          - brand_ambassador
        description: ソーシャルメディアインフルエンサーの名前。製品またはサービスをプロモーションするために使用されるソーシャルメディア上の有名人を示します。
        expr: INFLUENCER
        data_type: VARCHAR(16777216)
        sample_values:
          - NovaFitStar
      - name: PLATFORM
        synonyms:
          - channel
          - medium
          - site
          - social_media_channel
          - network
          - outlet
        description: ソーシャルメディアプラットフォーム。活動または関与が行われたソーシャルメディアのプラットフォームを示します。
        expr: PLATFORM
        data_type: VARCHAR(16777216)
        sample_values:
          - Instagram
          - Twitter
          - Facebook
    facts:
      - name: MENTIONS
        synonyms:
          - citations
          - references
          - quotes
          - allusions
          - name_drops
          - tags
          - shoutouts
          - credits
          - acknowledgments
        description: ブランド、製品、またはキーワードがソーシャルメディアプラットフォームで何回言及されたかを示す数値。
        expr: MENTIONS
        data_type: NUMBER(38,0)
        sample_values:
          - '16'
          - '6'
          - '9'
    time_dimensions:
      - name: DATE
        synonyms:
          - day
          - timestamp
          - calendar_date
          - posting_date
          - publication_date
          - entry_date
        description: ソーシャルメディアデータが収集または投稿された日付。
        expr: DATE
        data_type: DATE
        sample_values:
          - '2025-05-16'
          - '2025-05-17'
          - '2025-05-19'
relationships:
  - name: SALES_TO_PRODUCT
    left_table: SALES
    right_table: PRODUCTS
    relationship_columns:
      - left_column: PRODUCT_ID
        right_column: PRODUCT_ID
    relationship_type: many_to_one
    join_type: inner
  - name: MARKETING_TO_SOCIAL
    left_table: SOCIAL_MEDIA
    right_table: MARKETING_CAMPAIGN_METRICS
    relationship_columns:
      - left_column: CATEGORY
        right_column: CATEGORY
    relationship_type: many_to_one
    join_type: inner
verified_queries:
  - name: sales
    question: |+
      商品カテゴリごとの6月から8月までの売上トレンドを表示してください。

    use_as_onboarding_question: false
    sql: WITH monthly_sales AS (SELECT p.category, DATE_TRUNC('MONTH', s.date) AS month, SUM(s.sales_amount) AS monthly_sales FROM sales AS s INNER JOIN products AS p ON s.product_id = p.product_id WHERE s.date >= '2025-06-01' AND s.date < '2025-09-01' GROUP BY p.category, DATE_TRUNC('MONTH', s.date)) SELECT category, month, monthly_sales FROM monthly_sales ORDER BY category, month
    verified_by: D User
    verified_at: 1752091901
  $$
);

GRANT SELECT, REFERENCES ON SEMANTIC VIEW DB_SI_JP.RETAIL.Sales_And_Marketing_Data_BY_SQL TO ROLE PUBLIC;


-------------------------------------------------------------------------
--  Step 3. Implement Cortex Search
-------------------------------------------------------------------------

USE ROLE SNOWFLAKE_INTELLIGENCE_ADMIN;
CREATE OR REPLACE CORTEX SEARCH SERVICE DB_SI_JP.RETAIL.SUPPORT_CASES_BY_SQL
    ON transcript
    ATTRIBUTES title, product
    WAREHOUSE = WH_SI_JP
    TARGET_LAG = '1 hour'
AS (
    SELECT
      id
      , title
      , product
      , transcript
      , date
    FROM
      DB_SI_JP.RETAIL.SUPPORT_CASES
);

-------------------------------------------------------------------------
--  Step 4. Implement Cortex Agents
-------------------------------------------------------------------------

GRANT USAGE ON CORTEX SEARCH SERVICE DB_SI_JP.RETAIL.SUPPORT_CASES_BY_SQL TO ROLE PUBLIC;
SHOW CORTEX SEARCH SERVICES IN SCHEMA DB_SI_JP.RETAIL;

USE ROLE SNOWFLAKE_INTELLIGENCE_ADMIN;
CREATE OR REPLACE AGENT SNOWFLAKE_INTELLIGENCE.AGENTS.SALES_AI_by_SQL
  COMMENT = 'EC サイト向けデータ分析 AI エージェント'
  PROFILE = '{"display_name": "Sales//AI_by_SQL", "avatar": "🧠"}'
  FROM SPECIFICATION
  $$
  models:
    orchestration: claude-sonnet-4-5

  orchestration:
    budget:
      seconds: 30
      tokens: 16000

  instructions:
    sample_questions:
      - question: "6月から8月までの商品カテゴリー別の売上トレンドを見せてください"
      - question: "最近、カスタマーサポートチケットでジャケットについてどんな問題が報告されていますか？"
      - question: "7月にフィットネスウェアの売上がなぜそんなに伸びたのですか？"


  tools:
    - tool_spec:
        type: "cortex_analyst_text_to_sql"
        name: "Sales_And_Marketing_Data_by_SQL"
        description: "DB_SI_JP.RETAIL スキーマの Sales and Marketing Data モデルは、マーケティングキャンペーン、商品情報、売上データ、ソーシャルメディアエンゲージメントを接続することで、小売ビジネスのパフォーマンスの全体像を提供します。このモデルは、クリックとインプレッションを通じてマーケティングキャンペーンの効果を追跡することを可能にし、異なる地域の実際の売上パフォーマンスとリンクします。ソーシャルメディアエンゲージメントは、インフルエンサーの活動とメンションを通じて監視され、すべてのデータは商品カテゴリーとIDを通じて接続されます。テーブル間の時間的な整合性により、時間経過に伴うマーケティングの売上パフォーマンスとソーシャルメディアエンゲージメントへの影響を包括的に分析できます。"
    - tool_spec:
        type: "cortex_search"
        name: "Support_Cases_by_SQL"
        description: "Support Ceases Cortex Search"

  tool_resources:
    Sales_And_Marketing_Data_by_SQL:
      semantic_view: "DB_SI_JP.RETAIL.SALES_AND_MARKETING_DATA_BY_SQL"
    Support_Cases_by_SQL:
      name: "DB_SI_JP.RETAIL.SUPPORT_CASES_BY_SQL"
      max_results: "5"
      title_column: "TITLE"
      id_column: "ID"
  $$;

GRANT USAGE ON AGENT SNOWFLAKE_INTELLIGENCE.AGENTS.SALES_AI_by_SQL TO ROLE PUBLIC;