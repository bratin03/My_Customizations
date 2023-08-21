const int N = 1e7 + 9;
bool sieve[N];

void createSieve()
{
    for (int i = 2; i * i <= N; i++)
    {
        sieve[i] = 1;
    }

    for (int i = 2; i * i <= N; i++)
    {
        if (sieve[i] == 1)
        {
            for (int j = i * i; j <= N; j += i)
            {
                sieve[j] = 0;
            }
        }
    }
}