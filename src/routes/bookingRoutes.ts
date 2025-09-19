import { Router } from 'express';
import { Authorize } from '../middleware/authMiddleware';
import { createRecord, deleteRecord, getRecord, getRecords, getRecordsByUserId } from '../controllers/bookingController';
import catchAsync from '../utils/catchAsync';

const routes = Router();
routes.get('/', getRecords);
routes.get('/byId/:id', getRecord);
routes.get('/byUser', catchAsync(Authorize), catchAsync(getRecordsByUserId));
routes.post('/', catchAsync(Authorize), catchAsync(createRecord));
routes.delete('/:id', catchAsync(Authorize), catchAsync(deleteRecord));

export const bookingRoutes = routes;