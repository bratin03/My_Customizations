/*
    * Template for competitive programming using parallel threads
    * Author: Bratin Mondal

    * Department of Computer Science and Engineering
    * Indian Institute of Technology, Kharagpur
*/

#define HACKERCUP
#define STACK_INCREASE

#ifdef STACK_INCREASE
#define STACK_SIZE 1024 * 1024 * 1024
#endif

#include <bits/stdc++.h>
#include <thread>
#define ll long long
#define ull unsigned long long
#define endl "\n"
#define t(k) cin >> k
#define c(x) cout << x << endl
#define l(i, x, y) for (ll i = x; i < y; i++)
#define le(i, x, y) for (ll i = x; i <= y; i++)
#define lr(i, x, y) for (ll i = x - 1; i >= y; i--)
#define lre(i, x, y) for (ll i = x; i >= y; i--)
#define yes out << "YES" << endl
#define no out << "NO" << endl
#define prDouble(x) out << fixed << setprecision(10) << x
#define all(x) x.begin(), x.end()
#define rall(x) x.rbegin(), x.end()
#define maxv(v) *max_element(all(v))
#define minv(v) *min_element(all(v))
#define maxa(a) *max_element(a, a + n)
#define mina(a) *min_element(a, a + n)
#define deb(x) out << #x << "=" << x << endl
#define deb2(x, y) out << #x << "=" << x << "," << #y << "=" << y << endl
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

const ll MAX_THREADS = 1e2 + 9;
const ll MAX_TEST_CASES = 1e5 + 9;

ll tt = 1;
ll cur = 0;
stringstream out[MAX_TEST_CASES];
mutex mu;
thread threads[MAX_THREADS];

class Solution
{
public:
    // Declare variables here

    void read_data()
    {
        // Read data here
    }

    void solve(stringstream &out)
    {
        // Solve the problem here and output the result to out
    }
};

void solution_runnner()
{
    while (true)
    {
        Solution s;
        int id;
        mu.lock();
        if (cur >= tt)
        {
            mu.unlock();
            return;
        }
        id = cur;
        cur++;
        s.read_data();
        mu.unlock();
        s.solve(out[id]);
        cerr << "solved " << id << endl;
    }
}

void main_()
{
#ifdef HACKERCUP
    auto input = freopen("input.txt", "r", stdin);
    auto output = freopen("output.txt", "w", stdout);
    assert(input != nullptr && output != nullptr);
#endif

    fast;
    cin >> tt; // comment out if only one test case
    cur = 0;
    for (int i = 0; i < MAX_THREADS; i++)
    {
        threads[i] = thread(solution_runnner);
    }
    for (int i = 0; i < MAX_THREADS; i++)
    {
        threads[i].join();
    }
    for (int i = 0; i < tt; i++)
    {
#ifdef HACKERCUP
        cout << "Case #" << i + 1 << ": ";
#endif
        cout << out[i].str();
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