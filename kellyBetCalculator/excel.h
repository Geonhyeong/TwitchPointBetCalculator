#ifndef EXCEL_H
#define EXCEL_H

#include <QObject>
#include <QQuickItem>

#include "xlsxdocument.h"
#include "xlsxchartsheet.h"
#include "xlsxcellrange.h"
#include "xlsxchart.h"
#include "xlsxrichstring.h"
#include "xlsxworkbook.h"
using namespace QXlsx;

class Excel: public QObject
{
    Q_OBJECT
public:
    explicit Excel(QObject *parent = nullptr);
    virtual ~Excel();

    QVariant point = 0;
    QVariant a_win = 0;
    QVariant b_win = 0;

    Q_INVOKABLE void createFile(const QString &_source, const QString &_point, const QString &_aWinCount, const QString &_bWinCount);
    Q_INVOKABLE bool readFile(const QString &_source);
    Q_INVOKABLE QString getPoint();
    Q_INVOKABLE QString getAWin();
    Q_INVOKABLE QString getBWin();
    Q_INVOKABLE bool setBet(const QString &_source, const QString &_aAllocationRate, const QString &_bAllocationRate);
    Q_INVOKABLE QString getBetTeam();
    Q_INVOKABLE QString getBetPoint();
    Q_INVOKABLE bool editPoint(const QString &_source, const QString &_point);
    Q_INVOKABLE bool calcData(const QString &_source, const QString &_team, const QString &_aAlloc, const QString &_bAlloc);

private:
    QString betTeam;
    QString betPoint;
};

#endif // EXCEL_H
