#include <iostream>

#include "excel.h"
#include "kellybet.h"

Excel::Excel(QObject *parent)
    :QObject(parent)
{

}

Excel::~Excel()
{

}

void Excel::createFile(const QString &_source, const QString &_point, const QString &_aWinCount, const QString &_bWinCount)
{
    Document xlsx;
    // write current point
    xlsx.write("A1", "current point");
    xlsx.write("B1", _point);

    // write rate table
    xlsx.write("A3", "A");
    xlsx.write("A4", "B");
    xlsx.write("B2", "win count");

    // init rate data
    xlsx.write("B3", _aWinCount);
    xlsx.write("B4", _bWinCount);

    xlsx.saveAs(_source);
}

bool Excel::readFile(const QString &_source)
{
    Document doc(_source);
    if (!doc.load())
        return false;

    point = doc.read(1, 2);
    a_win = doc.read(3, 2);
    b_win = doc.read(4, 2);
    return true;
}

QString Excel::getPoint()
{
    return point.toString();
}
QString Excel::getAWin()
{
    double a = a_win.toInt();
    double b = b_win.toInt();
    if (a+b)
    {
        QVariant rate = a / (a+b) * 100;
        rate = rate.toInt();
        return rate.toString();
    }
    else {
        return "50";
    }
}
QString Excel::getBWin()
{
    double a = a_win.toInt();
    double b = b_win.toInt();
    if (a+b)
    {
        QVariant rate = b / (a+b) * 100;
        rate = rate.toInt();
        return rate.toString();
    }
    else {
        return "50";
    }
}

QString Excel::getBetTeam()
{
    return betTeam;
}
QString Excel::getBetPoint()
{
    return betPoint;
}

bool Excel::setBet(const QString &_source, const QString &_aAllocationRate, const QString &_bAllocationRate)
{
    if (!readFile(_source))
        return false;

    double aW = a_win.toInt();
    double bW = b_win.toInt();

    KellyBet kb_a(_aAllocationRate.toDouble() - 1, aW / (aW + bW));
    KellyBet kb_b(_bAllocationRate.toDouble() - 1, bW / (aW + bW));
    kb_a.setData();
    kb_b.setData();
    double f_a = kb_a.getData();
    double f_b = kb_b.getData();
    QVariant _betPoint;

    if (f_a > f_b)
    {
        betTeam = "A";
        if (f_b < 0)
        {
            f_b = -1 * f_b;
            if (f_a > f_b)
                _betPoint = f_a * point.toInt();
            else
                _betPoint = f_b * point.toInt();
        }
        else
            _betPoint = f_a * point.toInt();
    }
    else if (f_a == f_b)
    {
        if (f_a > 0)
        {
            betTeam = aW >= bW ? "A" : "B";
            _betPoint = aW >= bW ? f_a * point.toInt() : f_b * point.toInt();
        }
        else
        {
            betTeam = "X";
            _betPoint = 0;
        }
    }
    else
    {
        betTeam = "B";
        if (f_a < 0)
        {
            f_a = -1 * f_a;
            if (f_a > f_b)
                _betPoint = f_a * point.toInt();
            else
                _betPoint = f_b * point.toInt();
        }
        else
            _betPoint = f_b * point.toInt();
    }

    _betPoint = _betPoint.toInt();
    betPoint = _betPoint.toString();
    return true;
}

bool Excel::editPoint(const QString &_source, const QString &_point)
{
    Document doc(_source);
    if (!doc.load())
        return false;
    point = _point.toInt();

    doc.write("B1", point);
    doc.save();
    return true;
}

bool Excel::calcData(const QString &_source, const QString &_team, const QString &_aAlloc, const QString &_bAlloc)
{
    Document doc(_source);
    if (!doc.load())
        return false;

    int currentPoint = point.toInt();
    int bp = betPoint.toInt();
    double aAlloc = _aAlloc.toDouble();
    double bAlloc = _bAlloc.toDouble();
    int gp = 0; // get point

    if (_team == "A")
    {
        if (betTeam == _team)
        {
            a_win = a_win.toInt() + 1;
            gp = (int) (bp * aAlloc);
            currentPoint += gp;
        }
        else
            currentPoint -= bp;
    }
    else if (_team == "B")
    {
        if (betTeam == _team)
        {
            b_win = b_win.toInt() + 1;
            gp = (int) (bp * bAlloc);
            currentPoint += gp;
        }
        else
            currentPoint -= bp;
    }
    point = currentPoint;

    doc.write("B1", point);
    doc.write("B3", a_win);
    doc.write("B4", b_win);
    doc.save();
    return true;
}
