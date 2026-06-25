CREATE FUNCTION dbo.fn_capitalize (@input VARCHAR(8000))
RETURNS VARCHAR(8000)
AS
BEGIN
    IF @input IS NULL RETURN NULL;

    DECLARE @result VARCHAR(8000) = '';
    DECLARE @word VARCHAR(8000);
    DECLARE @wordUpper VARCHAR(8000);
    DECLARE @pos INT = 1;
    DECLARE @start INT = 1;
    DECLARE @len INT = LEN(@input);
    DECLARE @ch CHAR(1);

    WHILE @pos <= @len
    BEGIN
        SET @ch = SUBSTRING(@input, @pos, 1);
        IF @ch IN (' ', '-', '/', '.', ',')
        BEGIN
            SET @word = SUBSTRING(@input, @start, @pos - @start);
            SET @wordUpper = UPPER(@word);
            IF @wordUpper IN ('FT','IN','MM','CM','LB','LBS','OZ','KG',
                              'SQ','CU','GAL','QT','PT','ML',
                              'HR','HRS','MIN','SEC',
                              'PCS','PC','EA','PR','DZ','BX','CTN','PK','PKG')
                SET @result = @result + LOWER(@word);
            ELSE IF @word COLLATE Latin1_General_BIN = @wordUpper 
                 AND @word LIKE '%[A-Z]%'
                 AND LEN(@word) BETWEEN 2 AND 5
                SET @result = @result + @word;
            ELSE
                SET @result = @result + UPPER(LEFT(@word,1)) + LOWER(SUBSTRING(@word,2,LEN(@word)));

            SET @result = @result + @ch;
            SET @start = @pos + 1;
        END
        SET @pos = @pos + 1;
    END
    SET @word = SUBSTRING(@input, @start, @len - @start + 1);
    SET @wordUpper = UPPER(@word);

    IF @wordUpper IN ('FT','IN','MM','CM','LB','LBS','OZ','KG',
                      'SQ','CU','GAL','QT','PT','ML',
                      'HR','HRS','MIN','SEC',
                      'PCS','PC','EA','PR','DZ','BX','CTN','PK','PKG')
        SET @result = @result + LOWER(@word);
    ELSE IF @word COLLATE Latin1_General_BIN = @wordUpper 
         AND @word LIKE '%[A-Z]%'
         AND LEN(@word) BETWEEN 2 AND 5
        SET @result = @result + @word;
    ELSE
        SET @result = @result + UPPER(LEFT(@word,1)) + LOWER(SUBSTRING(@word,2,LEN(@word)));

    RETURN @result;
END;
GO

SELECT TOP 50
    item_no, item_desc_1 AS original_desc_1, dbo.fn_capitalize(item_desc_1) AS new_desc_1, item_desc_2 AS original_desc_2, dbo.fn_capitalize(item_desc_2) AS new_desc_2
FROM imitmadt_sql;