#include <bits/stdc++.h>
using namespace std;
#define ll long long

namespace graph
{
    class Graph
    {
    public:
        vector<vector<ll>> adj;
        ll n;
        Graph(ll m)
        {
            adj.resize(m + 1);
            n = m;
        }
        void addEdge_u(ll u, ll v)
        {
            adj[u].push_back(v);
        }
        void addEdge_d(ll u, ll v)
        {
            adj[u].push_back(v);
            adj[v].push_back(u);
        }
        void take_input_d(ll m)
        {
            ll x, y;
            cin >> x >> y;
            addEdge_d(x, y);
        }
        void take_input_u(ll m)
        {
            ll x, y;
            cin >> x >> y;
            addEdge_u(x, y);
        }
    };
}