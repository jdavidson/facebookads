view: base {
  extension: required

  dimension: base_primary_key {
    hidden: yes
    type: string
    sql: concat(
      ${account_id},
      ${account_name},
      ${campaign_id},
      ${campaign_name},
      ${ad_id},
      ${ad_name},
      ${adset_id},
      ${adset_name},
      ${date_start_raw},
      ${date_stop_raw}
    ) ;;
  }

  measure: total_impressions {
    type: sum
    sql: ${impressions} ;;
    label: "Impressions"
    description: "Total ad impressions."
    value_format_name: decimal_0
  }

  measure: total_reach {
    type: sum
    sql: ${reach} ;;
    label: "Reach"
    description: "Total ad reach. This will count users that see multiple ads multiple times."
    value_format_name: decimal_0
  }

  measure: total_clicks {
    type: sum
    sql: ${clicks} ;;
    label: "Clicks"
    description: "Total ad clicks."
    value_format_name: decimal_0
  }

  measure: total_spend {
    type: sum
    sql: ${spend} ;;
    label: "Spend"
    description: "Total spend."
    value_format_name: usd_0
  }

  measure: average_cost_per_impression {
    label: "CPM"
    description: "Average cost per 1000 ad impressions viewed."
    type: number
    sql: ${total_spend}*1000.0 / NULLIF(${total_impressions},0) ;;
    value_format_name: usd
  }

  measure: average_cost_per_click {
    label: "CPC"
    description: "Average cost per ad click."
    type: number
    sql: ${total_spend}*1.0 / NULLIF(${total_clicks},0) ;;
    value_format_name: usd
  }

  measure: average_click_rate {
    label: "CTR"
    description: "Percent of people that click on an ad."
    type: number
    sql: ${total_clicks}*1.0/nullif(${total_impressions},0) ;;
    value_format_name: percent_2
  }

  measure: average_frequency {
    label: "Frequency"
    description: "Average impressions per reach."
    type: number
    sql: ${total_impressions}*1.0 / NULLIF(${total_reach},0) ;;
    value_format_name: decimal_2
  }

  dimension: account_id {
    type: string
    sql: ${TABLE}.account_id ;;
  }

  dimension: account_name {
    type: string
    sql: ${TABLE}.account_name ;;
  }

  dimension: ad_id {
    type: string
    sql: ${TABLE}.ad_id ;;
  }

  dimension: ad_name {
    type: string
    sql: ${TABLE}.ad_name ;;
  }

  dimension: adset_id {
    type: string
    sql: ${TABLE}.adset_id ;;
  }

  dimension: adset_name {
    type: string
    sql: ${TABLE}.adset_name ;;
  }

  dimension: campaign_id {
    type: string
    sql: ${TABLE}.campaign_id ;;
  }

  dimension: campaign_name {
    type: string
    sql: ${TABLE}.campaign_name ;;
  }

  dimension_group: date_start {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.date_start ;;
  }

  dimension_group: date_stop {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.date_stop ;;
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
      date_stop_raw
    ]
  }
}
