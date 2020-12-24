#include "kellybet.h"

KellyBet::KellyBet(const double &_b, const double &_p)
{
    b = _b;
    p = _p;
    q = 1 - _p;
}

double KellyBet::getData() const
{
    return f;
}

void KellyBet::setData()
{
    f = ((b * p) - q) / b;
}
