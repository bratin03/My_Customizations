namespace pandc
{
    vector<ll> FACTORIAL(MAXN);
    vector<ll> POWER(MAXN);
    void initFACTORIAL()
    {
        FACTORIAL[0] = 1;
        for (ll i = 1; i < MAXN; i++)
        {
            FACTORIAL[i] = (FACTORIAL[i - 1] * i) % MOD;
        }
    }
    void initPOWER(ll x)
    {
        POWER[0] = 1;
        for (ll i = 1; i < MAXN; i++)
        {
            POWER[i] = (POWER[i - 1] * (x % MOD)) % MOD;
        }
    }

    ll combination(ll n, ll k)
    {
        if (k > n)
            return 0;

        ll p1 = (FACTORIAL[n] * mod_inv(FACTORIAL[k], MOD)) % MOD;
        ll p2 = (1 * mod_inv(FACTORIAL[n - k], MOD)) % MOD;
        return (p1 * p2) % MOD;
    }

}

using namespace pandc;
