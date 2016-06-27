- dashboard: overview
  title: Overview
  layout: grid
  rows:
    - elements: [total_impressions, total_actions, total_spend]
      height: 150
    - elements: [spend_actions_impressions]
      height: 400
    - elements: [campaign_performance]
      height: 400
    - elements: [campaign_value]
      height: 400
    - elements: [campaign_delivery]
      height: 400
    - elements: [actions_by_country]
      height: 400
    - elements: [campaign_performance_and_clicks]
      height: 400
    - elements: [actions_by_type, avg_frequency_by_objective]
      height: 400
    - elements: [campaign_engagement]
      height: 400

#  filters:

  elements:
  
  - name: total_impressions
    title: Untitled Visualization
    type: single_value
    model: facebook
    explore: facebook_ads_insights
    measures: [facebook_ads_insights.total_impressions]
    sorts: [facebook_ads_insights.total_impressions desc]
    limit: 500
    show_single_value_title: true
    show_comparison: false
  
  - name: total_actions
    title: Untitled Visualization
    type: single_value
    model: facebook
    explore: facebook_ads_insights
    measures: [facebook_ads_insights.total_actions]
    sorts: [facebook_ads_insights.total_actions desc]
    limit: 500
    show_single_value_title: true
    show_comparison: false
    
  - name: total_spend
    title: Untitled Visualization
    type: single_value
    model: facebook
    explore: facebook_ads_insights
    measures: [facebook_ads_insights.total_actions]
    sorts: [facebook_ads_insights.total_actions desc]
    limit: 500
    show_single_value_title: true
    show_comparison: false
    
  - name: spend_actions_impressions
    title: Untitled Visualization
    type: looker_line
    model: facebook
    explore: facebook_ads_insights
    dimensions: [facebook_ads_insights.date_start_month]
    measures: [facebook_ads_insights.total_spend, facebook_ads_insights.total_actions,
      facebook_ads_insights.total_impressions]
    sorts: [facebook_ads_insights.date_start_month desc]
    limit: 500
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: false
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: none
    interpolation: linear
    
  - name: campaign_performance
    title: Untitled Table
    type: table
    model: facebook
    explore: facebook_ads_insights
    dimensions: [facebook_campaigns.name, facebook_adsets.end_date, facebook_adsets.effective_status,
      facebook_campaigns.objective]
    measures: [facebook_ads_insights.total_actions, facebook_ads_insights.total_clicks,
      facebook_ads_insights.total_reach, facebook_ads_insights.total_spend]
    dynamic_fields:
    - table_calculation: cost_per_action
      label: cost_per_action
      expression: ${facebook_ads_insights.total_spend} / ${facebook_ads_insights.total_actions}
    sorts: [facebook_campaigns.name]
    limit: 500
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    table_theme: editable
    limit_displayed_rows: false
    
  - name: campaign_value
    title: Untitled Visualization
    type: looker_scatter
    model: facebook
    explore: facebook_ads_insights
    dimensions: [facebook_campaigns.name]
    measures: [facebook_ads_insights.total_actions, facebook_ads_insights.total_spend]
    dynamic_fields:
    - table_calculation: cost_per_action
      label: Cost per action
      expression: ${facebook_ads_insights.total_spend} / ${facebook_ads_insights.total_actions}
    hidden_fields: [facebook_ads_insights.total_spend, facebook_campaigns.name]
    sorts: [cost_per_action desc]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: circle
    
  - name: campaign_delivery
    title: Untitled Table
    type: table
    model: facebook
    explore: facebook_ads_insights
    dimensions: [facebook_campaigns.name, facebook_adsets.end_date, facebook_adsets.effective_status,
      facebook_campaigns.objective]
    measures: [facebook_ads_insights.total_reach, facebook_ads_insights.avg_frequency,
      facebook_ads_insights.avg_cpp, facebook_ads_insights.avg_cpm, facebook_ads_insights.total_impressions]
    sorts: [facebook_campaigns.name]
    limit: 500
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    table_theme: editable
    limit_displayed_rows: false
    
  - name: actions_by_country
    title: Untitled Visualization
    type: looker_geo_choropleth
    model: facebook
    explore: facebook_ads_insights_country
    dimensions: [facebook_ads_insights_country.country_iso]
    measures: [facebook_ads_insights_country.total_actions]
    sorts: [facebook_ads_insights_country.total_actions desc]
    limit: 500
    map: auto
    show_view_names: true
    quantize_colors: false
    
  - name: campaign_performance_and_clicks
    title: Untitled Table
    type: table
    model: facebook
    explore: facebook_ads_insights
    dimensions: [facebook_campaigns.name, facebook_adsets.effective_status, facebook_adsets.end_date,
      facebook_campaigns.objective]
    measures: [facebook_ads_insights.total_actions, facebook_ads_insights.total_reach,
      facebook_ads_insights.avg_frequency, facebook_ads_insights.total_clicks, facebook_ads_insights.avg_ctr,
      facebook_ads_insights.avg_cpc, facebook_ads_insights.total_impressions, facebook_ads_insights.avg_cpm,
      facebook_ads_insights.total_inline_link_clicks, facebook_ads_insights.avg_inline_link_click_ctr,
      facebook_ads_insights.avg_cost_per_inline_link_click, facebook_ads_insights.total_spend]
    sorts: [facebook_ads_insights.total_actions desc]
    limit: 500
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    table_theme: editable
    limit_displayed_rows: false
    
  - name: actions_by_type
    title: Untitled Visualization
    type: looker_pie
    model: facebook
    explore: facebook_ads_insights__actions
    dimensions: [facebook_ads_insights__actions.action_type]
    measures: [facebook_ads_insights__actions.total_actions]
    sorts: [facebook_ads_insights__actions.total_actions desc]
    limit: 500
    value_labels: legend
    show_view_names: true
    
  - name: avg_frequency_by_objective
    title: Untitled Visualization
    type: looker_column
    model: facebook
    explore: facebook_ads_insights
    dimensions: [facebook_campaigns.objective]
    measures: [facebook_ads_insights.avg_frequency]
    sorts: [facebook_ads_insights.avg_frequency desc]
    limit: 500
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_labels: false
    
  - name: campaign_engagement
    title: Untitled Table
    type: table
    model: facebook
    explore: facebook_ads_insights__actions
    dimensions: [facebook_campaigns.name, facebook_adsets.effective_status, facebook_adsets.end_date,
      facebook_campaigns.objective]
    measures: [facebook_ads_insights__actions.post_likes, facebook_ads_insights__actions.post_comments,
      facebook_ads_insights__actions.link_clicks, facebook_ads_insights__actions.page_likes,
      facebook_ads_insights__actions.post_shares]
    sorts: [facebook_campaigns.name]
    limit: 500
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    table_theme: editable
    limit_displayed_rows: false