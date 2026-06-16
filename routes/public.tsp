import "@typespec/http";
import "../models/common.tsp";
import "../models/owner.tsp";
import "../models/event-type.tsp";
import "../models/slot.tsp";
import "../models/booking.tsp";

using Http;

namespace BookingApi;

/**
 * Публичная часть API — сценарий гостя без регистрации и авторизации.
 */
@tag("Public")
@route("/public")
namespace Public {
  /** Профиль владельца для шапки страницы бронирования (имя, таймзона). */
  @summary("Профиль владельца")
  @route("/owner")
  @get
  op getOwner(): Owner;

  /** Список активных типов событий, доступных для записи. */
  @summary("Список активных типов событий")
  @route("/event-types")
  @get
  op listEventTypes(): EventType[];

  /**
   * Свободные слоты под конкретный тип события, сгруппированные по дням.
   * По умолчанию — окно 14 дней вперёд; диапазон можно сузить через `from`/`to`.
   */
  @summary("Свободные слоты типа события")
  @route("/event-types/{eventTypeId}/slots")
  @get
  op listSlots(
    @path eventTypeId: string,

    /** Начало диапазона дат (включительно). */
    @query from?: plainDate,

    /** Конец диапазона дат (включительно). */
    @query to?: plainDate,
  ): DaySlots[] | NotFoundError;

  /**
   * Создать бронь. Сразу подтверждается (автоподтверждение), слот занимается.
   * Возвращает созданную бронь как подтверждение.
   */
  @summary("Создать бронь")
  @route("/bookings")
  @post
  op createBooking(
    @body body: BookingCreate,
  ): {
    @statusCode statusCode: 201;
    @body booking: Booking;
  } | ConflictError | ValidationError | NotFoundError;
}
