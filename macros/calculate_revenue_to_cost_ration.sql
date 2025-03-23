{% macro calculate_revenue_to_cost_ratio(revenue, cost) %}
    CASE
        WHEN {{ cost }} > 0 THEN ({{ revenue }} / {{ cost }})
        ELSE 0
    END
{% endmacro %}