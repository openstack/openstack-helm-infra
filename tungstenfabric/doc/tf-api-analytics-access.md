# How to access Contrail Analytics and Config APIs in OSH Cluster?


OpenStack Helm supports Fernet token for OpenStack Keystone. Please check OSH fernet token support for keystone blueprint URL in reference section for more details.

### Steps to get the token and use with Analytics API:

* 1st step is getting the token and please use following command to get the token.


```
 # openstack token issue
+------------+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Field      | Value                                                                                                                                                                                   |
+------------+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| expires    | 2018-02-09T23:21:11+0000                                                                                                                                                                |
| id         | gAAAAABafh7XDMVGefTtoY5P0rdLcV2gk4Oi3pc0U5Fq6fLp7ECdhCO1PG4Coam9FeCy-GNivFkWy3wtQ2ElpxpvcX0HzLBRO4JwW6QNPB9SrrRwHsjdokAdPkFoJgzJ1Yx4N7QBVJqKcBuUWIuUf5bvnJzhegWrRp5J9rnJzPYvF9wI4467kVY |
| project_id | 5fa242182853488e87345e873f2c3e25                                                                                                                                                        |
| user_id    | b5bc80c7ccb448f6a29d5822d67d9922                                                                                                                                                        |
+------------+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
````
Once you get the token you can set ENV variable and use it in your CURL as described below. In below example vrouters UVE data is pulled via Contrail Analytics port 8081 using Keystone fernet token.

```
# export TOKEN_ID=gAAAAABafh7XDMVGefTtoY5P0rdLcV2gk4Oi3pc0U5Fq6fLp7ECdhCO1PG4Coam9FeCy-GNivFkWy3wtQ2ElpxpvcX0HzLBRO4JwW6QNPB9SrrRwHsjdokAdPkFoJgzJ1Yx4N7QBVJqKcBuUWIuUf5bvnJzhegWrRp5J9rnJzPYvF9wI4467kVY

# curl -X GET -H "X-Auth-Token: $TOKEN_ID" http://10.13.82.233:8081/analytics/uves/vrouters | python -m json.tool
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   309  100   309    0     0   9043      0 --:--:-- --:--:-- --:--:--  9363
[
    {
        "href": "http://10.13.82.233:8081/analytics/uves/vrouter/vntc-server6?flat",
        "name": "vntc-server6"
    },
    {
        "href": "http://10.13.82.233:8081/analytics/uves/vrouter/vntc-server5?flat",
        "name": "vntc-server5"
    },
    {
        "href": "http://10.13.82.233:8081/analytics/uves/vrouter/vntc-server4?flat",
        "name": "vntc-server4"
    }
]
```

### Refernces:

* https://blueprints.launchpad.net/openstack-helm/+spec/keystone-fernet-tokens
