class KellyBet
{
public:
    // 켈리 공식을 이용한 최적 베팅규모 계산기
    // 패배 시 베팅 금액 전체를 날리고, 승리시 베팅금액x배당률을 획득하는 단순한 베팅을 생각해보면,
    // 켈리 공식은 아래와 같다.
    // f = (bp - q) / b = {p(b + 1)-1} / b
    // 결과가 0일 경우, 한 푼도 걸지 말 것을 추천한다.
    // 결과가 음인 경우, 도박사가 반대편에 베팅해야 한다는 것을 의미한다.

    explicit KellyBet(const double &_b, const double &_p);

    double b; // 순배당률, 예로 1원을 베팅하고 승리할 경우 베팅한 돈 1원에 더해 b원을 추가로 획득.
    double p; // 승리 확률
    double q; // 패배 확률; 1 - p

    double getData() const;
    void setData(void);

private:
    double f; // 보유자금 대비 베팅금액의 비율; 베팅 규모
};
