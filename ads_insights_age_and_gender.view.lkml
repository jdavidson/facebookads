include: "stitch.view.lkml"
include: "base_insights.view.lkml"

view: ads_insights_age_and_gender {
  extends: ["stitch", "base_insights"]

  sql_table_name: {{ _user_attributes["facebook_schema"] }}.ads_insights_age_and_gender ;;

  dimension: primary_key {
    hidden: yes
    type: string
    primary_key: yes
    expression: concat(
      ${base_primary_key},
      ${age},
      ${gender}
    ) ;;
  }

  dimension: age {
    type: string
    sql: ${TABLE}.age ;;
  }

  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
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
      age,
      gender
    ]
  }
}
