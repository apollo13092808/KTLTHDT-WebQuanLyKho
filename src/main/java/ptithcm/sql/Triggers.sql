USE [INT14103]
GO
/*Them san pham vao kho khi them 1 san pham moi*/
CREATE TRIGGER [dbo].[trg_AddProductInStock] ON [dbo].[product] After Insert as
Begin
INSERT INTO DBO.stock VALUES ((SELECT inserted.code FROM inserted), 0, 1, (GETDATE()), (GETDATE()));
END

/*Cap nhat so lương san pham trong kho khi them, xoa, sua phieu nhap receipt_detail*/

GO
CREATE TRIGGER [dbo].[trg_UpdateQuantityProductInStock_InsertReceipt_detail] ON [dbo].[receipt_detail] After Insert as
Begin
	Update dbo.stock set quantity = dbo.stock.quantity + (select quantity from inserted where product_code = dbo.stock.product_code)
		from dbo.stock join inserted on dbo.stock.product_code = inserted.product_code
END


GO
CREATE TRIGGER [dbo].[trg_UpdateQuantityProductInStock_UpdateReceipt_detail] ON [dbo].[receipt_detail] AFTER UPDATE AS
BEGIN
	UPDATE dbo.stock SET quantity = dbo.stock.quantity +
	   (SELECT Inserted.quantity FROM inserted WHERE Inserted.product_code = dbo.stock.product_code) -
	   (SELECT Deleted.quantity FROM deleted WHERE Deleted.product_code = dbo.stock.product_code)
   FROM dbo.stock 
   JOIN deleted ON dbo.stock.product_code = deleted.product_code
END


GO
CREATE TRIGGER [dbo].[trg_UpdateQuantityProductInStock_DeleteReceipt_detail] ON [dbo].[receipt_detail] FOR DELETE AS 
BEGIN
	UPDATE dbo.stock
	SET quantity = st.quantity - (SELECT Deleted.quantity FROM deleted WHERE st.product_code = product_code)
	FROM dbo.stock st 
	JOIN deleted ON st.product_code = deleted.product_code
END

/*Cap nhat so lương san pham trong kho khi them, xoa, sua phieu xuat issue_detail*/

GO
CREATE TRIGGER [dbo].[trg_UpdateQuantityProductInStock_InsertIssue_detail] ON [dbo].[issue_detail] After Insert as
Begin
	Update dbo.stock set quantity = dbo.stock.quantity - (select quantity from inserted where product_code = dbo.stock.product_code)
		from dbo.stock join inserted on dbo.stock.product_code = inserted.product_code
END


GO
CREATE TRIGGER [dbo].[trg_UpdateQuantityProductInStock_UpdateIssue_detail] ON [dbo].[issue_detail] AFTER UPDATE AS
BEGIN
	UPDATE dbo.stock SET quantity = dbo.stock.quantity +
	   (SELECT Deleted.quantity FROM deleted WHERE Deleted.product_code = dbo.stock.product_code) -
	   (SELECT Inserted.quantity FROM inserted WHERE Inserted.product_code = dbo.stock.product_code)
   FROM dbo.stock 
   JOIN deleted ON dbo.stock.product_code = deleted.product_code
END


GO
CREATE TRIGGER [dbo].[trg_UpdateQuantityProductInStock_DeleteIssue_detail] ON [dbo].[issue_detail] FOR DELETE AS 
BEGIN
	UPDATE dbo.stock
	SET quantity = st.quantity + (SELECT Deleted.quantity FROM deleted WHERE st.product_code = product_code)
	FROM dbo.stock st 
	JOIN deleted ON st.product_code = deleted.product_code
END
