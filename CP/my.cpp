/*
    * Template for competitive programming
    * Author: Bratin Mondal

    * Deparment of Computer Science and Engineering
    * Indian Institue of Technology, Kharagpur
*/

#include <bits/stdc++.h>
#define ll long long
#define ull unsigned long long
#define endl "\n"
#define vi vector<int>
#define vll vector<ll>
#define pii pair<int, int>
#define pll pair<ll, ll>
#define vpii vector<pii>
#define vpll vector<pll>
#define vvi vector<vi>
#define vvl vector<vll>
#define t(k) cin >> k
#define c(x) cout << x << endl
#define l(i, x, y) for (ll i = x; i < y; i++)
#define le(i, x, y) for (ll i = x; i <= y; i++)
#define lr(i, x, y) for (ll i = x - 1; i >= y; i--)
#define lre(i, x, y) for (ll i = x; i >= y; i--)
#define yes cout << "YES" << endl
#define no cout << "NO" << endl
#define prDouble(x) cout << fixed << setprecision(10) << x
#define all(x) x.begin(), x.end()
#define rall(x) x.rbegin(), x.end()
#define maxv(v) *max_element(all(v))
#define minv(v) *min_element(all(v))
#define maxa(a) *max_element(a, a + n)
#define mina(a) *min_element(a, a + n)
#define deb(x) cout << #x << "=" << x << endl
#define deb2(x, y) cout << #x << "=" << x << "," << #y << "=" << y << endl
#define sortall(x) sort(all(x))
#define PI acos(-1)
#define cin_2d(vec, n, m)                               \
    for (int i = 0; i < n; i++)                         \
        for (int j = 0; j < m && cin >> vec[i][j]; j++) \
            ;
#define cout_2d(vec, n, m)                                      \
    for (int i = 0; i < n; i++, cout << "\n")                   \
        for (int j = 0; j < m && cout << vec[i][j] << " "; j++) \
            ;
#define fast                          \
    ios_base::sync_with_stdio(false); \
    cin.tie(nullptr);                 \
    cout.tie(nullptr);
using namespace std;
const ll MOD = 1e9 + 7;
const ll MAXN = 1e5 + 9;

ll fast_mul(ll a, ll b) { return ((a % MOD) * (b % MOD)) % MOD; }

ll binpow(ll a, ll b)
{
    if (b == 0)
        return 1;
    int ans = binpow(a, b / 2);
    ans = fast_mul(ans, ans);
    if (b % 2)
    {
        return fast_mul(ans, a);
    }
    return ans;
}

ll mod_inv(ll a, ll m = MOD)
{
    return binpow(a, m - 2);
}

void solve()
{
    // your code goes here
}

int main()
{
    fast;
    ll t = 1;
    cin >> t; // comment out if only one test case
    while (t--)
    {
        solve();
    }
    exit(0);
}
