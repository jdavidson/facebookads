include: "stitch.view.lkml"
include: "base_insights.view.lkml"

view: ads_insights_platform_and_device {
  extends: ["stitch", "base_insights"]

  sql_table_name: {{ _user_attributes["facebook_schema"] }}.ads_insights_platform_and_device ;;

  dimension: primary_key {
    hidden: yes
    type: string
    primary_key: yes
    expression: concat(
      ${base_primary_key},
      ${impression_device},
      ${platform_position},
      ${publisher_platform}
    ) ;;
  }

  dimension: impression_device {
    type: string
    sql: ${TABLE}.impression_device ;;
  }

  dimension: platform_position {
    type: string
    sql: ${TABLE}.platform_position ;;
  }

  dimension: publisher_platform {
    type: string
    sql: ${TABLE}.publisher_platform ;;
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      account_id,
      account_name,
      campaign_id,
      campaign_name,
      ad_id,
      ad_name,
      adset_id,
      adset_name,
      date_start_raw,
      date_stop_raw,
      impression_device,
      platform_position,
      publisher_platform
    ]
  }
}
