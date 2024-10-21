class FenwickTree
{
public:
    vector<int> fen;
    int N;

    FenwickTree(int n) : N(n)
    {
        fen.resize(n + 1);
    }

    void update(int i, int add)
    {
        while (i < N)
        {
            fen[i] += add;
            i += (i & (-i));
        }
    }

    void build(vector<int> &arr)
    {
        for (int i = 0; i < N; i++)
        {
            update(i, arr[i]);
        }
    }

    int sum(int i)
    {
        int s = 0;
        while (i > 0)
        {
            s += fen[i];
            i = i - (i & (-i));
        }
        return s;
    }

    int find(int k)
    {
        int curr = 0, ans = 0, prevsum = 0;
        for (int i = log2(N); i >= 0; i--)
        {
            if (fen[curr + (1 << i)] + prevsum < k)
            {
                curr = curr + (1 << i);
                prevsum += fen[curr];
            }
        }
        return (curr + 1);
    }
};