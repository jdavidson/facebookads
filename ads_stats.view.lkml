include: "facebook_ads.model.lkml"
include: "base.view.lkml"

view: ads_stats {
  extends: ["base"]

  derived_table: {
    explore_source: ads_insights {
      column: account_id {}
      column: account_name {}
      column: campaign_id {}
      column: campaign_name {}
      column: adset_id {}
      column: adset_name {}
      column: ad_id {}
      column: ad_name {}
      column: date_start_raw {}
      column: date_stop_raw {}
      column: total_impressions {}
      column: total_reach {}
      column: average_frequency {}
      column: total_clicks {}
      column: total_spend {}
    }
  }
  dimension: impressions {
    label: "Impressions"
    value_format: "#,##0"
    type: number
    sql: ${TABLE}.total_impressions ;;
  }
  dimension: reach {
    label: "Reach"
    description: "Ad reach. This will count users that see multiple ads multiple times."
    value_format: "#,##0"
    type: number
    sql: ${TABLE}.total_reach ;;
  }
  dimension: frequency {
    label: "Frequency"
    description: "Average impressions per reach."
    type: number
    sql: ${TABLE}.average_frequency ;;
  }
  dimension: clicks {
    label: "Clicks"
    value_format: "#,##0"
    type: number
    sql: ${TABLE}.total_clicks ;;
  }
  dimension: spend {
    label: "Spend"
    value_format: "$#,##0"
    type: number
    sql: ${TABLE}.total_spend ;;
  }
}
