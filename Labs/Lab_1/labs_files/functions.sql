create or replace function net_worth( target_costumer_name varchar)
returns int
language plpgsql
as
    $$
    DECLARE assets INT DEFAULT 0;
    DECLARE dept INT DEFAULT 0;
    DECLARE net_worth INT DEFAULT 0;
    BEGIN
        SELECT sum(l.amount) INTO dept
        FROM loan l JOIN borrower b ON l.loan_number = b.loan_number
        WHERE b.customer_name like target_costumer_name;

        SELECT sum(a.balance) INTO assets
        FROM account a JOIN depositor d ON a.account_number =   d.account_number
        WHERE d.customer_name like target_costumer_name;
        net_worth = assets - dept;
        RETURN net_worth;
    END;
    $$;

select net_worth(target_costumer_name := 'Cook');

CREATE OR REPLACE FUNCTION tg_delete_account_fn()
RETURNS TRIGGER LANGUAGE plpgsql AS
    $$
    BEGIN
        DELETE FROM depositor
        WHERE depositor.account_number = OLD.account_number;
        RETURN NEW;
    END;
    $$;

DROP TRIGGER tg_delete_account ON ACCOUNT;

CREATE TRIGGER tg_delete_account BEFORE DELETE ON account
FOR EACH ROW EXECUTE PROCEDURE tg_delete_account_fn();

DELETE FROM account
WHERE  account.account_number = 'A-101';