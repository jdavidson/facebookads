connection: "bigquery-connectors-facebook-ads"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"

datagroup: facebook_ads_default_datagroup {
  sql_trigger: SELECT MAX(_sdc_extracted_at) FROM ads_insight ;;
  max_cache_age: "24 hours"
}

persist_with: facebook_ads_default_datagroup

explore: adcreative {
  extension: required

  join: adcreative__object_story_spec {
    view_label: "Adcreative: Object Story Spec"
    sql: LEFT JOIN UNNEST([${adcreative.object_story_spec}]) as adcreative__object_story_spec ;;
    relationship: one_to_one
  }

  join: adcreative__object_story_spec__video_data__call_to_action {
    view_label: "Adcreative: Object Story Spec Video Data Call To Action"
    sql: LEFT JOIN UNNEST([${adcreative__object_story_spec__video_data.call_to_action}]) as adcreative__object_story_spec__video_data__call_to_action ;;
    relationship: one_to_one
  }

  join: adcreative__object_story_spec__video_data__call_to_action__value {
    view_label: "Adcreative: Object Story Spec Video Data Call To Action Value"
    sql: LEFT JOIN UNNEST([${adcreative__object_story_spec__video_data__call_to_action.value}]) as adcreative__object_story_spec__video_data__call_to_action__value ;;
    relationship: one_to_one
  }

  join: adcreative__object_story_spec__video_data {
    view_label: "Adcreative: Object Story Spec Video Data"
    sql: LEFT JOIN UNNEST([${adcreative__object_story_spec.video_data}]) as adcreative__object_story_spec__video_data ;;
    relationship: one_to_one
  }

  join: adcreative__object_story_spec__link_data__call_to_action {
    view_label: "Adcreative: Object Story Spec Link Data Call To Action"
    sql: LEFT JOIN UNNEST([${adcreative__object_story_spec__link_data.call_to_action}]) as adcreative__object_story_spec__link_data__call_to_action ;;
    relationship: one_to_one
  }

  join: adcreative__object_story_spec__link_data {
    view_label: "Adcreative: Object Story Spec Link Data"
    sql: LEFT JOIN UNNEST([${adcreative__object_story_spec.link_data}]) as adcreative__object_story_spec__link_data ;;
    relationship: one_to_one
  }
}

explore: ads {
  extension: required

  join: adcreative {
    type: left_outer
    sql_on: ${ads.creative_id} = ${adcreative.id} ;;
    relationship: one_to_one
  }

  join: adsets {
    type: left_outer
    sql_on: ${ads.adset_id} = ${adsets.id} ;;
    relationship: many_to_one
  }

  join: campaigns {
    type: left_outer
    sql_on: ${ads.campaign_id} = ${campaigns.id} ;;
    relationship: many_to_one
  }

  join: ads__conversion_specs {
    view_label: "Ads: Conversion Specs"
    sql: LEFT JOIN UNNEST([${ads.conversion_specs}]) as ads__conversion_specs ;;
    relationship: one_to_one
  }

  join: ads__bid_info {
    view_label: "Ads: Bid Info"
    sql: LEFT JOIN UNNEST([${ads.bid_info}]) as ads__bid_info ;;
    relationship: one_to_one
  }

  join: ads__recommendations {
    view_label: "Ads: Recommendations"
    sql: LEFT JOIN UNNEST(${ads.recommendations}) as ads__recommendations ;;
    relationship: one_to_many
  }

  join: ads__targeting {
    view_label: "Ads: Targeting"
    sql: LEFT JOIN UNNEST([${ads.targeting}]) as ads__targeting ;;
    relationship: one_to_one
  }

  join: ads__targeting__friends_of_connections {
    view_label: "Ads: Targeting Friends Of Connections"
    sql: LEFT JOIN UNNEST(${ads__targeting.friends_of_connections}) as ads__targeting__friends_of_connections ;;
    relationship: one_to_many
  }

  join: ads__targeting__geo_locations__regions {
    view_label: "Ads: Targeting Geo Locations Regions"
    sql: LEFT JOIN UNNEST(${ads__targeting__geo_locations.regions}) as ads__targeting__geo_locations__regions ;;
    relationship: one_to_many
  }

  join: ads__targeting__geo_locations {
    view_label: "Ads: Targeting Geo Locations"
    sql: LEFT JOIN UNNEST([${ads__targeting.geo_locations}]) as ads__targeting__geo_locations ;;
    relationship: one_to_one
  }

  join: ads__targeting__geo_locations__cities {
    view_label: "Ads: Targeting Geo Locations Cities"
    sql: LEFT JOIN UNNEST(${ads__targeting__geo_locations.cities}) as ads__targeting__geo_locations__cities ;;
    relationship: one_to_many
  }

  join: ads__targeting__geo_locations__countries {
    view_label: "Ads: Targeting Geo Locations Countries"
    sql: LEFT JOIN UNNEST(${ads__targeting__geo_locations.countries}) as ads__targeting__geo_locations__countries ;;
    relationship: one_to_many
  }

  join: ads__targeting__geo_locations__location_types {
    view_label: "Ads: Targeting Geo Locations Location Types"
    sql: LEFT JOIN UNNEST(${ads__targeting__geo_locations.location_types}) as ads__targeting__geo_locations__location_types ;;
    relationship: one_to_many
  }

  join: ads__targeting__geo_locations__zips {
    view_label: "Ads: Targeting Geo Locations Zips"
    sql: LEFT JOIN UNNEST(${ads__targeting__geo_locations.zips}) as ads__targeting__geo_locations__zips ;;
    relationship: one_to_many
  }

  join: ads__targeting__custom_audiences {
    view_label: "Ads: Targeting Custom Audiences"
    sql: LEFT JOIN UNNEST(${ads__targeting.custom_audiences}) as ads__targeting__custom_audiences ;;
    relationship: one_to_many
  }

  join: ads__targeting__flexible_spec__work_positions {
    view_label: "Ads: Targeting Flexible Spec Work Positions"
    sql: LEFT JOIN UNNEST(${ads__targeting__flexible_spec.work_positions}) as ads__targeting__flexible_spec__work_positions ;;
    relationship: one_to_many
  }

  join: ads__targeting__flexible_spec__friends_of_connections {
    view_label: "Ads: Targeting Flexible Spec Friends Of Connections"
    sql: LEFT JOIN UNNEST(${ads__targeting__flexible_spec.friends_of_connections}) as ads__targeting__flexible_spec__friends_of_connections ;;
    relationship: one_to_many
  }

  join: ads__targeting__flexible_spec__behaviors {
    view_label: "Ads: Targeting Flexible Spec Behaviors"
    sql: LEFT JOIN UNNEST(${ads__targeting__flexible_spec.behaviors}) as ads__targeting__flexible_spec__behaviors ;;
    relationship: one_to_many
  }

  join: ads__targeting__flexible_spec__interests {
    view_label: "Ads: Targeting Flexible Spec Interests"
    sql: LEFT JOIN UNNEST(${ads__targeting__flexible_spec.interests}) as ads__targeting__flexible_spec__interests ;;
    relationship: one_to_many
  }

  join: ads__targeting__flexible_spec__connections {
    view_label: "Ads: Targeting Flexible Spec Connections"
    sql: LEFT JOIN UNNEST(${ads__targeting__flexible_spec.connections}) as ads__targeting__flexible_spec__connections ;;
    relationship: one_to_many
  }

  join: ads__targeting__flexible_spec__work_employers {
    view_label: "Ads: Targeting Flexible Spec Work Employers"
    sql: LEFT JOIN UNNEST(${ads__targeting__flexible_spec.work_employers}) as ads__targeting__flexible_spec__work_employers ;;
    relationship: one_to_many
  }

  join: ads__targeting__interests {
    view_label: "Ads: Targeting Interests"
    sql: LEFT JOIN UNNEST(${ads__targeting.interests}) as ads__targeting__interests ;;
    relationship: one_to_many
  }

  join: ads__tracking_specs {
    view_label: "Ads: Tracking Specs"
    sql: LEFT JOIN UNNEST([${ads.tracking_specs}]) as ads__tracking_specs ;;
    relationship: one_to_one
  }

  join: ads__targeting__flexible_spec {
    view_label: "Ads: Targeting Flexible Spec"
    sql: LEFT JOIN UNNEST(${ads__targeting.flexible_spec}) as ads__targeting__flexible_spec ;;
    relationship: one_to_one
  }
}


explore: adsets {
  extension: required

  join: campaigns {
    type: left_outer
    sql_on: ${adsets.campaign_id} = ${campaigns.id} ;;
    relationship: many_to_one
  }

  join: adsets__bid_info {
    view_label: "Adsets: Bid Info"
    sql: LEFT JOIN UNNEST([${adsets.bid_info}]) as adsets__bid_info ;;
    relationship: one_to_one
  }

  join: adsets__targeting {
    view_label: "Adsets: Targeting"
    sql: LEFT JOIN UNNEST([${adsets.targeting}]) as adsets__targeting ;;
    relationship: one_to_one
  }

  join: adsets__targeting__flexible_spec__work_positions {
    view_label: "Adsets: Targeting Flexible Spec Work Positions"
    sql: LEFT JOIN UNNEST(${adsets__targeting__flexible_spec.work_positions}) as adsets__targeting__flexible_spec__work_positions ;;
    relationship: one_to_many
  }

  join: adsets__targeting__flexible_spec__friends_of_connections {
    view_label: "Adsets: Targeting Flexible Spec Friends Of Connections"
    sql: LEFT JOIN UNNEST(${adsets__targeting__flexible_spec.friends_of_connections}) as adsets__targeting__flexible_spec__friends_of_connections ;;
    relationship: one_to_many
  }

  join: adsets__targeting__flexible_spec__behaviors {
    view_label: "Adsets: Targeting Flexible Spec Behaviors"
    sql: LEFT JOIN UNNEST(${adsets__targeting__flexible_spec.behaviors}) as adsets__targeting__flexible_spec__behaviors ;;
    relationship: one_to_many
  }

  join: adsets__targeting__flexible_spec__interests {
    view_label: "Adsets: Targeting Flexible Spec Interests"
    sql: LEFT JOIN UNNEST(${adsets__targeting__flexible_spec.interests}) as adsets__targeting__flexible_spec__interests ;;
    relationship: one_to_many
  }

  join: adsets__targeting__flexible_spec__connections {
    view_label: "Adsets: Targeting Flexible Spec Connections"
    sql: LEFT JOIN UNNEST(${adsets__targeting__flexible_spec.connections}) as adsets__targeting__flexible_spec__connections ;;
    relationship: one_to_many
  }

  join: adsets__targeting__flexible_spec__work_employers {
    view_label: "Adsets: Targeting Flexible Spec Work Employers"
    sql: LEFT JOIN UNNEST(${adsets__targeting__flexible_spec.work_employers}) as adsets__targeting__flexible_spec__work_employers ;;
    relationship: one_to_many
  }

  join: adsets__targeting__geo_locations__regions {
    view_label: "Adsets: Targeting Geo Locations Regions"
    sql: LEFT JOIN UNNEST(${adsets__targeting__geo_locations.regions}) as adsets__targeting__geo_locations__regions ;;
    relationship: one_to_many
  }

  join: adsets__targeting__geo_locations {
    view_label: "Adsets: Targeting Geo Locations"
    sql: LEFT JOIN UNNEST([${adsets__targeting.geo_locations}]) as adsets__targeting__geo_locations ;;
    relationship: one_to_one
  }

  join: adsets__targeting__geo_locations__cities {
    view_label: "Adsets: Targeting Geo Locations Cities"
    sql: LEFT JOIN UNNEST(${adsets__targeting__geo_locations.cities}) as adsets__targeting__geo_locations__cities ;;
    relationship: one_to_many
  }

  join: adsets__targeting__geo_locations__countries {
    view_label: "Ads: Targeting Geo Locations Countries"
    sql: LEFT JOIN UNNEST(${adsets__targeting__geo_locations.countries}) as adsets__targeting__geo_locations__countries ;;
    relationship: one_to_many
  }

  join: adsets__targeting__geo_locations__location_types {
    view_label: "Ads: Targeting Geo Locations Location Types"
    sql: LEFT JOIN UNNEST(${adsets__targeting__geo_locations.location_types}) as adsets__targeting__geo_locations__location_types ;;
    relationship: one_to_many
  }

  join: adsets__targeting__geo_locations__zips {
    view_label: "Adsets: Targeting Geo Locations Zips"
    sql: LEFT JOIN UNNEST(${adsets__targeting__geo_locations.zips}) as adsets__targeting__geo_locations__zips ;;
    relationship: one_to_many
  }

  join: adsets__targeting__custom_audiences {
    view_label: "Adsets: Targeting Custom Audiences"
    sql: LEFT JOIN UNNEST(${adsets__targeting.custom_audiences}) as adsets__targeting__custom_audiences ;;
    relationship: one_to_many
  }

  join: adsets__promoted_object {
    view_label: "Adsets: Promoted Object"
    sql: LEFT JOIN UNNEST([${adsets.promoted_object}]) as adsets__promoted_object ;;
    relationship: one_to_one
  }

  join: adsets__targeting__flexible_spec {
    view_label: "Adsets: Targeting Flexible Spec"
    sql: LEFT JOIN UNNEST([${adsets__targeting.flexible_spec}]) as adsets__targeting__flexible_spec ;;
    relationship: one_to_one
  }
}

explore: campaigns {
  extension: required

  join: campaigns__ads__data {
    view_label: "Campaigns: Ads Data"
    sql: LEFT JOIN UNNEST(${campaigns__ads.data}) as campaigns__ads__data ;;
    relationship: one_to_many
  }

  join: campaigns__ads {
    view_label: "Campaigns: Ads"
    sql: LEFT JOIN UNNEST([${campaigns.ads}]) as campaigns__ads ;;
    relationship: one_to_one
  }
}

explore: ads_insights {
  extends: ["campaigns", "adsets", "ads"]

  join: campaigns {
    type: left_outer
    sql_on: ${ads_insights.campaign_id} = ${campaigns.id} ;;
    relationship: many_to_one
  }

  join: adsets {
    type: left_outer
    sql_on: ${ads_insights.adset_id} = ${adsets.id} ;;
    relationship: many_to_one
  }

  join: ads {
    type: left_outer
    sql_on: ${ads_insights.ad_id} = ${ads.id} ;;
    relationship: many_to_one
  }

  join: ads_insights__video_30_sec_watched_actions {
    view_label: "Ads Insights: Video 30 Sec Watched Actions"
    sql: LEFT JOIN UNNEST(${ads_insights.video_30_sec_watched_actions}) as ads_insights__video_30_sec_watched_actions ;;
    relationship: one_to_many
  }

  join: ads_insights__video_p75_watched_actions {
    view_label: "Ads Insights: Video P75 Watched Actions"
    sql: LEFT JOIN UNNEST(${ads_insights.video_p75_watched_actions}) as ads_insights__video_p75_watched_actions ;;
    relationship: one_to_many
  }

  join: ads_insights__video_p95_watched_actions {
    view_label: "Ads Insights: Video P95 Watched Actions"
    sql: LEFT JOIN UNNEST(${ads_insights.video_p95_watched_actions}) as ads_insights__video_p95_watched_actions ;;
    relationship: one_to_many
  }

  join: ads_insights__actions {
    view_label: "Ads Insights: Actions"
    sql: LEFT JOIN UNNEST(${ads_insights.actions}) as ads_insights__actions ;;
    relationship: one_to_many
  }

  join: ads_insights__website_ctr {
    view_label: "Ads Insights: Website Ctr"
    sql: LEFT JOIN UNNEST(${ads_insights.website_ctr}) as ads_insights__website_ctr ;;
    relationship: one_to_many
  }

  join: ads_insights__video_15_sec_watched_actions {
    view_label: "Ads Insights: Video 15 Sec Watched Actions"
    sql: LEFT JOIN UNNEST(${ads_insights.video_15_sec_watched_actions}) as ads_insights__video_15_sec_watched_actions ;;
    relationship: one_to_many
  }

  join: ads_insights__video_10_sec_watched_actions {
    view_label: "Ads Insights: Video 10 Sec Watched Actions"
    sql: LEFT JOIN UNNEST(${ads_insights.video_10_sec_watched_actions}) as ads_insights__video_10_sec_watched_actions ;;
    relationship: one_to_many
  }

  join: ads_insights__unique_actions {
    view_label: "Ads Insights: Unique Actions"
    sql: LEFT JOIN UNNEST(${ads_insights.unique_actions}) as ads_insights__unique_actions ;;
    relationship: one_to_many
  }

  join: ads_insights__video_p25_watched_actions {
    view_label: "Ads Insights: Video P25 Watched Actions"
    sql: LEFT JOIN UNNEST(${ads_insights.video_p25_watched_actions}) as ads_insights__video_p25_watched_actions ;;
    relationship: one_to_many
  }

  join: ads_insights__video_p100_watched_actions {
    view_label: "Ads Insights: Video P100 Watched Actions"
    sql: LEFT JOIN UNNEST(${ads_insights.video_p100_watched_actions}) as ads_insights__video_p100_watched_actions ;;
    relationship: one_to_many
  }

  join: ads_insights__video_p50_watched_actions {
    view_label: "Ads Insights: Video P50 Watched Actions"
    sql: LEFT JOIN UNNEST(${ads_insights.video_p50_watched_actions}) as ads_insights__video_p50_watched_actions ;;
    relationship: one_to_many
  }

  join: ads_insights__relevance_score {
    view_label: "Ads Insights: Relevance Score"
    sql: LEFT JOIN UNNEST([${ads_insights.relevance_score}]) as ads_insights__relevance_score ;;
    relationship: one_to_one
  }
}

explore: ads_insights_age_and_gender {
  extends: ["campaigns", "adsets", "ads"]

  join: campaigns {
    type: left_outer
    sql_on: ${ads_insights_age_and_gender.campaign_id} = ${campaigns.id} ;;
    relationship: many_to_one
  }

  join: ads {
    type: left_outer
    sql_on: ${ads_insights_age_and_gender.ad_id} = ${ads.id} ;;
    relationship: many_to_one
  }

  join: adcreative {
    type: left_outer
    sql_on: ${ads.creative_id} = ${adcreative.id} ;;
    relationship: one_to_one
  }

  join: adsets {
    type: left_outer
    sql_on: ${ads_insights_age_and_gender.adset_id} = ${adsets.id} ;;
    relationship: many_to_one
  }

  join: ads_insights__video_30_sec_watched_actions {
    view_label: "Ads Insights Age And Gender: Video 30 Sec Watched Actions"
    sql: LEFT JOIN UNNEST(${ads_insights_age_and_gender.video_30_sec_watched_actions}) as ads_insights__video_30_sec_watched_actions ;;
    relationship: one_to_many
  }

  join: ads_insights__video_p75_watched_actions {
    view_label: "Ads Insights Age And Gender: Video P75 Watched Actions"
    sql: LEFT JOIN UNNEST(${ads_insights_age_and_gender.video_p75_watched_actions}) as ads_insights__video_p75_watched_actions ;;
    relationship: one_to_many
  }

  join: ads_insights__video_p95_watched_actions {
    view_label: "Ads Insights Age And Gender: Video P95 Watched Actions"
    sql: LEFT JOIN UNNEST(${ads_insights_age_and_gender.video_p95_watched_actions}) as ads_insights__video_p95_watched_actions ;;
    relationship: one_to_many
  }

  join: ads_insights__actions {
    view_label: "Ads Insights Age And Gender: Actions"
    sql: LEFT JOIN UNNEST(${ads_insights_age_and_gender.actions}) as ads_insights__actions ;;
    relationship: one_to_many
  }

  join: ads_insights__website_ctr {
    view_label: "Ads Insights Age And Gender: Website Ctr"
    sql: LEFT JOIN UNNEST(${ads_insights_age_and_gender.website_ctr}) as ads_insights__website_ctr ;;
    relationship: one_to_many
  }

  join: ads_insights__video_15_sec_watched_actions {
    view_label: "Ads Insights Age And Gender: Video 15 Sec Watched Actions"
    sql: LEFT JOIN UNNEST(${ads_insights_age_and_gender.video_15_sec_watched_actions}) as ads_insights__video_15_sec_watched_actions ;;
    relationship: one_to_many
  }

  join: ads_insights__video_10_sec_watched_actions {
    view_label: "Ads Insights Age And Gender: Video 10 Sec Watched Actions"
    sql: LEFT JOIN UNNEST(${ads_insights_age_and_gender.video_10_sec_watched_actions}) as ads_insights__video_10_sec_watched_actions ;;
    relationship: one_to_many
  }

  join: ads_insights__unique_actions {
    view_label: "Ads Insights Age And Gender: Unique Actions"
    sql: LEFT JOIN UNNEST(${ads_insights_age_and_gender.unique_actions}) as ads_insights__unique_actions ;;
    relationship: one_to_many
  }

  join: ads_insights__video_p25_watched_actions {
    view_label: "Ads Insights Age And Gender: Video P25 Watched Actions"
    sql: LEFT JOIN UNNEST(${ads_insights_age_and_gender.video_p25_watched_actions}) as ads_insights__video_p25_watched_actions ;;
    relationship: one_to_many
  }

  join: ads_insights__video_p100_watched_actions {
    view_label: "Ads Insights Age And Gender: Video P100 Watched Actions"
    sql: LEFT JOIN UNNEST(${ads_insights_age_and_gender.video_p100_watched_actions}) as ads_insights__video_p100_watched_actions ;;
    relationship: one_to_many
  }

  join: ads_insights__video_p50_watched_actions {
    view_label: "Ads Insights Age And Gender: Video P50 Watched Actions"
    sql: LEFT JOIN UNNEST(${ads_insights_age_and_gender.video_p50_watched_actions}) as ads_insights__video_p50_watched_actions ;;
    relationship: one_to_many
  }
}

explore: ads_insights_country {
  extends: ["campaigns", "adsets", "ads"]

  join: campaigns {
    type: left_outer
    sql_on: ${ads_insights_country.campaign_id} = ${campaigns.id} ;;
    relationship: many_to_one
  }

  join: ads {
    type: left_outer
    sql_on: ${ads_insights_country.ad_id} = ${ads.id} ;;
    relationship: many_to_one
  }

  join: adcreative {
    type: left_outer
    sql_on: ${ads.creative_id} = ${adcreative.id} ;;
    relationship: one_to_one
  }

  join: adsets {
    type: left_outer
    sql_on: ${ads_insights_country.adset_id} = ${adsets.id} ;;
    relationship: many_to_one
  }

  join: ads_insights__video_30_sec_watched_actions {
    view_label: "Ads Insights Country: Video 30 Sec Watched Actions"
    sql: LEFT JOIN UNNEST(${ads_insights_country.video_30_sec_watched_actions}) as ads_insights__video_30_sec_watched_actions ;;
    relationship: one_to_many
  }

  join: ads_insights__video_p75_watched_actions {
    view_label: "Ads Insights Country: Video P75 Watched Actions"
    sql: LEFT JOIN UNNEST(${ads_insights_country.video_p75_watched_actions}) as ads_insights__video_p75_watched_actions ;;
    relationship: one_to_many
  }

  join: ads_insights__video_p95_watched_actions {
    view_label: "Ads Insights Country: Video P95 Watched Actions"
    sql: LEFT JOIN UNNEST(${ads_insights_country.video_p95_watched_actions}) as ads_insights__video_p95_watched_actions ;;
    relationship: one_to_many
  }

  join: ads_insights__actions {
    view_label: "Ads Insights Country: Actions"
    sql: LEFT JOIN UNNEST(${ads_insights_country.actions}) as ads_insights__actions ;;
    relationship: one_to_many
  }

  join: ads_insights__website_ctr {
    view_label: "Ads Insights Country: Website Ctr"
    sql: LEFT JOIN UNNEST(${ads_insights_country.website_ctr}) as ads_insights__website_ctr ;;
    relationship: one_to_many
  }

  join: ads_insights__video_15_sec_watched_actions {
    view_label: "Ads Insights Country: Video 15 Sec Watched Actions"
    sql: LEFT JOIN UNNEST(${ads_insights_country.video_15_sec_watched_actions}) as ads_insights__video_15_sec_watched_actions ;;
    relationship: one_to_many
  }

  join: ads_insights__video_10_sec_watched_actions {
    view_label: "Ads Insights Country: Video 10 Sec Watched Actions"
    sql: LEFT JOIN UNNEST(${ads_insights_country.video_10_sec_watched_actions}) as ads_insights__video_10_sec_watched_actions ;;
    relationship: one_to_many
  }

  join: ads_insights__unique_actions {
    view_label: "Ads Insights Country: Unique Actions"
    sql: LEFT JOIN UNNEST(${ads_insights_country.unique_actions}) as ads_insights__unique_actions ;;
    relationship: one_to_many
  }

  join: ads_insights__video_p25_watched_actions {
    view_label: "Ads Insights Country: Video P25 Watched Actions"
    sql: LEFT JOIN UNNEST(${ads_insights_country.video_p25_watched_actions}) as ads_insights__video_p25_watched_actions ;;
    relationship: one_to_many
  }

  join: ads_insights__video_p100_watched_actions {
    view_label: "Ads Insights Country: Video P100 Watched Actions"
    sql: LEFT JOIN UNNEST(${ads_insights_country.video_p100_watched_actions}) as ads_insights__video_p100_watched_actions ;;
    relationship: one_to_many
  }

  join: ads_insights__video_p50_watched_actions {
    view_label: "Ads Insights Country: Video P50 Watched Actions"
    sql: LEFT JOIN UNNEST(${ads_insights_country.video_p50_watched_actions}) as ads_insights__video_p50_watched_actions ;;
    relationship: one_to_many
  }
}

explore: ads_insights_platform_and_device {
  extends: ["campaigns", "adsets", "ads"]

  join: campaigns {
    type: left_outer
    sql_on: ${ads_insights_platform_and_device.campaign_id} = ${campaigns.id} ;;
    relationship: many_to_one
  }

  join: ads {
    type: left_outer
    sql_on: ${ads_insights_platform_and_device.ad_id} = ${ads.id} ;;
    relationship: many_to_one
  }

  join: adcreative {
    type: left_outer
    sql_on: ${ads.creative_id} = ${adcreative.id} ;;
    relationship: one_to_one
  }

  join: adsets {
    type: left_outer
    sql_on: ${ads_insights_platform_and_device.adset_id} = ${adsets.id} ;;
    relationship: many_to_one
  }

  join: ads_insights__video_30_sec_watched_actions {
    view_label: "Ads Insights Platform And Device: Video 30 Sec Watched Actions"
    sql: LEFT JOIN UNNEST(${ads_insights_platform_and_device.video_30_sec_watched_actions}) as ads_insights__video_30_sec_watched_actions ;;
    relationship: one_to_many
  }

  join: ads_insights__video_p75_watched_actions {
    view_label: "Ads Insights Platform And Device: Video P75 Watched Actions"
    sql: LEFT JOIN UNNEST(${ads_insights_platform_and_device.video_p75_watched_actions}) as ads_insights__video_p75_watched_actions ;;
    relationship: one_to_many
  }

  join: ads_insights__video_p95_watched_actions {
    view_label: "Ads Insights Platform And Device: Video P95 Watched Actions"
    sql: LEFT JOIN UNNEST(${ads_insights_platform_and_device.video_p95_watched_actions}) as ads_insights__video_p95_watched_actions ;;
    relationship: one_to_many
  }

  join: ads_insights__actions {
    view_label: "Ads Insights Platform And Device: Actions"
    sql: LEFT JOIN UNNEST(${ads_insights_platform_and_device.actions}) as ads_insights__actions ;;
    relationship: one_to_many
  }

  join: ads_insights__website_ctr {
    view_label: "Ads Insights Platform And Device: Website Ctr"
    sql: LEFT JOIN UNNEST(${ads_insights_platform_and_device.website_ctr}) as ads_insights__website_ctr ;;
    relationship: one_to_many
  }

  join: ads_insights__video_15_sec_watched_actions {
    view_label: "Ads Insights Platform And Device: Video 15 Sec Watched Actions"
    sql: LEFT JOIN UNNEST(${ads_insights_platform_and_device.video_15_sec_watched_actions}) as ads_insights__video_15_sec_watched_actions ;;
    relationship: one_to_many
  }

  join: ads_insights__video_10_sec_watched_actions {
    view_label: "Ads Insights Platform And Device: Video 10 Sec Watched Actions"
    sql: LEFT JOIN UNNEST(${ads_insights_platform_and_device.video_10_sec_watched_actions}) as ads_insights__video_10_sec_watched_actions ;;
    relationship: one_to_many
  }

  join: ads_insights__unique_actions {
    view_label: "Ads Insights Platform And Device: Unique Actions"
    sql: LEFT JOIN UNNEST(${ads_insights_platform_and_device.unique_actions}) as ads_insights__unique_actions ;;
    relationship: one_to_many
  }

  join: ads_insights__video_p25_watched_actions {
    view_label: "Ads Insights Platform And Device: Video P25 Watched Actions"
    sql: LEFT JOIN UNNEST(${ads_insights_platform_and_device.video_p25_watched_actions}) as ads_insights__video_p25_watched_actions ;;
    relationship: one_to_many
  }

  join: ads_insights__video_p100_watched_actions {
    view_label: "Ads Insights Platform And Device: Video P100 Watched Actions"
    sql: LEFT JOIN UNNEST(${ads_insights_platform_and_device.video_p100_watched_actions}) as ads_insights__video_p100_watched_actions ;;
    relationship: one_to_many
  }

  join: ads_insights__video_p50_watched_actions {
    view_label: "Ads Insights Platform And Device: Video P50 Watched Actions"
    sql: LEFT JOIN UNNEST(${ads_insights_platform_and_device.video_p50_watched_actions}) as ads_insights__video_p50_watched_actions ;;
    relationship: one_to_many
  }
}
