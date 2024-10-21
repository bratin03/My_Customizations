/*
    * Template for competitive programming
    * Author: Bratin Mondal

    * Deparment of Computer Science and Engineering
    * Indian Institue of Technology, Kharagpur
*/

// #define HACKERCUP
// #define STACK_INCREASE

#ifdef STACK_INCREASE
#define STACK_SIZE 1024 * 1024 * 1024
#endif

#include <bits/stdc++.h>
#define ll long long
#define ull unsigned long long
#define endl "\n"
#define t(k) cin >> k
#define c(x) cout << x << endl
#define l(i, x, y) for (ll i = x; i < y; i++)
#define le(i, x, y) for (ll i = x; i <= y; i++)
#define yes cout << "YES" << endl
#define no cout << "NO" << endl
#define prDouble(x) cout << fixed << setprecision(10) << x
#define all(x) x.begin(), x.end()
#define rall(x) x.rbegin(), x.end()
#define clr(x) memset(x, 0, sizeof(x))
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
using namespace std;

const ll MOD = 1e9 + 7;
const ll MAXN = 1e5 + 9;

void test_case_num(ll i)
{
    cout << "Case #" << i << ": ";
}

ll fast_mul(ll a, ll b)
{
    return ((a % MOD) * (b % MOD)) % MOD;
}

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
{ // your code goes here
}

void main_()
{
    ios_base::sync_with_stdio(false);
    cin.tie(nullptr);
    cout.tie(nullptr);

#ifdef HACKERCUP
    auto input = freopen("input.txt", "r", stdin);
    auto output = freopen("output.txt", "w", stdout);
    assert(input != nullptr && output != nullptr);
#endif

    ll t = 1;
    cin >> t;
    ll i = 1;
    while (t--)
    {
        test_case_num(i);
        solve();
        i++;
    }
}

#ifdef STACK_INCREASE
static void run_with_stack_size(void (*func)(void), size_t stsize)
{
    char *stack, *send;
    stack = (char *)malloc(stsize);
    send = stack + stsize - 16;
    send = (char *)((uintptr_t)send / 16 * 16);
    asm volatile(
        "mov %%rsp, (%0)\n"
        "mov %0, %%rsp\n"
        :
        : "r"(send));
    func();
    asm volatile("mov (%0), %%rsp\n" : : "r"(send));
    free(stack);
}
#endif

int main()
{
#ifdef STACK_INCREASE
    run_with_stack_size(main_, STACK_SIZE);
#else
    main_();
#endif
}